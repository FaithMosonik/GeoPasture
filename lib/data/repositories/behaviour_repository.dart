import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';

import '../../database/app_database.dart';
import '../../database/tables/behaviour_classification.dart';
import '../../database/tables/distress_alert.dart';
import '../local/dao/animal_dao.dart';
import '../local/dao/behaviour_classification_dao.dart';
import '../local/dao/distress_alert_dao.dart';
import '../../features/behaviour/models/classification_result.dart';
import '../../features/behaviour/models/time_budget.dart';
import '../../features/behaviour/services/alert_service.dart';
import '../../features/behaviour/services/classification_service.dart';
import '../../features/behaviour/services/preprocessing_service.dart';
import '../../features/behaviour/services/viterbi_service.dart';

class BehaviourRepository {
  final AnimalDao _animalDao;
  final BehaviourClassificationDao _classificationDao;
  final DistressAlertDao _distressAlertDao;
  final PreprocessingService _preprocessingService;
  final ClassificationService _classificationService;
  final ViterbiService _viterbiService;
  final AlertService _alertService;

  static const _uuid = Uuid();

  BehaviourRepository({
    required AnimalDao animalDao,
    required BehaviourClassificationDao classificationDao,
    required DistressAlertDao distressAlertDao,
    required PreprocessingService preprocessingService,
    required ClassificationService classificationService,
    required ViterbiService viterbiService,
    required AlertService alertService,
  })  : _animalDao = animalDao,
        _classificationDao = classificationDao,
        _distressAlertDao = distressAlertDao,
        _preprocessingService = preprocessingService,
        _classificationService = classificationService,
        _viterbiService = viterbiService,
        _alertService = alertService;

  // ── Inference ────────────────────────────────────────────────────────────

  /// Resolves the animal from [wearableId], runs the full inference pipeline,
  /// and persists the raw result. Returns null if no animal owns the wearable.
  Future<ClassificationResult?> classifyWindow(
    String wearableId,
    List<AccelerometerReadingData> readings,
  ) async {
    final animal = await _animalDao.getAnimalByWearableId(wearableId);
    if (animal == null) return null;

    final windowStart = readings.first.timestamp;
    final windowEnd = readings.last.timestamp;

    final window = _preprocessingService.prepareWindow(readings);
    final result = await _classificationService.classify(
      animal.id,
      window,
      windowStart,
      windowEnd,
    );

    await _classificationDao.insertClassification(
      BehaviourClassificationCompanion(
        id: Value(_uuid.v4()),
        animalId: Value(animal.id),
        timestamp: Value(DateTime.now()),
        behaviourClass: Value(result.behaviourClass),
        confidence: Value(result.confidence),
        windowStart: Value(result.windowStart),
        windowEnd: Value(result.windowEnd),
        probGrazing: Value(result.probGrazing),
        probRuminating: Value(result.probRuminating),
        probStanding: Value(result.probStanding),
        probLying: Value(result.probLying),
        probWalking: Value(result.probWalking),
      ),
    );

    return result;
  }

  // ── Time budgets ─────────────────────────────────────────────────────────

  /// Returns the Viterbi-smoothed time budget for [animalId] on [date].
  Future<TimeBudget> getDailyTimeBudget(String animalId, DateTime date) async {
    final smoothed = await _getSmoothedClasses(animalId, date);
    return _buildTimeBudget(animalId, date, smoothed);
  }

  /// Aggregates per-animal budgets into a single herd-level [TimeBudget].
  /// Window counts are summed directly before computing percentages to avoid
  /// the rounding error of converting percent → count → percent.
  Future<TimeBudget> getHerdDailyTimeBudget(
    String herdId,
    DateTime date,
  ) async {
    final animals = await _animalDao.getAnimalsByHerd(herdId);
    final allClasses = <int>[];
    for (final animal in animals) {
      allClasses.addAll(await _getSmoothedClasses(animal.id, date));
    }
    return _buildTimeBudget(herdId, date, allClasses);
  }

  // ── Alerts ───────────────────────────────────────────────────────────────

  /// Computes today's smoothed budget and inserts [DistressAlert] rows for any
  /// threshold breaches. Intended to be called by the WorkManager periodic job.
  /// Returns the IDs of alerts inserted (empty list if no breaches).
  Future<List<String>> evaluateAlerts(
    String animalId,
    String pastoralistId,
    DateTime date,
  ) async {
    final animal = await _animalDao.getAnimalById(animalId);
    if (animal == null) return [];

    final budget = await getDailyTimeBudget(animalId, date);
    if (budget.totalWindows == 0) return [];

    final latest = await _classificationDao.getLatestForAnimal(animalId);
    if (latest == null) return [];

    return _alertService.evaluateAndAlert(
      budget: budget,
      animal: animal,
      pastoralistId: pastoralistId,
      lastClassificationId: latest.id,
    );
  }

  Future<List<DistressAlertData>> getActiveAlerts() =>
      _distressAlertDao.getUnacknowledgedAlerts();

  Future<void> acknowledgeAlert(String alertId) =>
      _distressAlertDao.acknowledgeAlert(alertId);

  // ── Animal queries ───────────────────────────────────────────────────────

  Future<List<AnimalData>> getAnimalsByHerd(String herdId) =>
      _animalDao.getAnimalsByHerd(herdId);

  Future<BehaviourClassificationData?> getLatestClassification(
    String animalId,
  ) =>
      _classificationDao.getLatestForAnimal(animalId);

  // ── Private helpers ──────────────────────────────────────────────────────

  Future<List<int>> _getSmoothedClasses(String animalId, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final raw = await _classificationDao.getByAnimalAndDateRange(
      animalId,
      start,
      end,
    );
    if (raw.isEmpty) return [];
    return _viterbiService.smoothClasses(
      raw.map((c) => c.behaviourClass).toList(),
    );
  }

  TimeBudget _buildTimeBudget(String id, DateTime date, List<int> classes) {
    if (classes.isEmpty) {
      return TimeBudget(
        animalId: id,
        date: date,
        grazingPercent: 0,
        ruminatingPercent: 0,
        standingPercent: 0,
        lyingPercent: 0,
        walkingPercent: 0,
        totalWindows: 0,
      );
    }

    final counts = List<int>.filled(5, 0);
    for (final cls in classes) {
      counts[cls]++;
    }
    final total = classes.length;

    return TimeBudget(
      animalId: id,
      date: date,
      grazingPercent: counts[BehaviourClass.grazing] / total * 100,
      ruminatingPercent: counts[BehaviourClass.ruminating] / total * 100,
      standingPercent: counts[BehaviourClass.standing] / total * 100,
      lyingPercent: counts[BehaviourClass.lying] / total * 100,
      walkingPercent: counts[BehaviourClass.walking] / total * 100,
      totalWindows: total,
    );
  }
}
