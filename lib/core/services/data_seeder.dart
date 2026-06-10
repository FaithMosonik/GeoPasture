import 'dart:math';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../database/app_database.dart';
import '../../database/tables/behaviour_classification.dart';
import '../../database/tables/distress_alert.dart';

/// Populates the local database with two weeks of realistic demo data.
/// Only runs when the Animal table is empty — safe to leave in production
/// until real sensor data takes over.
class DataSeeder {
  final AppDatabase _db;
  static const _uuid = Uuid();
  final Random _rng = Random(42); // fixed seed → reproducible demo data

  DataSeeder(this._db);

  // ── Demo identity constants ─────────────────────────────────────────────
  static const _pastoralistId = 'demo-pastoralist-001';
  static const _herdId        = 'demo-herd-001';

  static const _animalDefs = [
    (id: 'demo-animal-001', name: 'Bessie', species: 'cattle', wearable: 'WBL-001'),
    (id: 'demo-animal-002', name: 'Daisy',  species: 'cattle', wearable: 'WBL-002'),
    (id: 'demo-animal-003', name: 'Rosie',  species: 'cattle', wearable: 'WBL-003'),
    (id: 'demo-animal-004', name: 'Bruno',  species: 'cattle', wearable: 'WBL-004'),
    (id: 'demo-animal-005', name: 'Luna',   species: 'cattle', wearable: 'WBL-005'),
    (id: 'demo-animal-006', name: 'Mia',    species: 'cattle', wearable: 'WBL-006'),
    (id: 'demo-animal-007', name: 'Max',    species: 'cattle', wearable: 'WBL-007'),
    (id: 'demo-animal-008', name: 'Cleo',   species: 'cattle', wearable: 'WBL-008'),
  ];

  // 288 windows/day = one window every 5 min → full 24-hour coverage
  static const _windowsPerDay = 288;

  // History depth
  static const _daysOfHistory = 7;

  // Behaviour distributions — [grazing, ruminating, standing, lying, walking]
  static const _normal      = [0.40, 0.30, 0.20, 0.07, 0.03]; // healthy
  static const _lowGraze    = [0.03, 0.30, 0.40, 0.25, 0.02]; // Bessie today → HIGH
  static const _lowRumin    = [0.40, 0.02, 0.30, 0.25, 0.03]; // Daisy today  → MEDIUM
  static const _highWalking = [0.10, 0.05, 0.00, 0.00, 0.85]; // Mia today    → MEDIUM

  // ── Public entry point ──────────────────────────────────────────────────

  Future<void> seedIfEmpty() async {
    final existing = await _db.select(_db.animal).get();
    if (existing.isNotEmpty) return;
    await _seed();
  }

  // ── Private seeding logic ───────────────────────────────────────────────

  Future<void> _seed() async {
    await _insertPastoralist();
    await _insertHerd();
    await _insertAnimals();

    final today = DateTime.now();

    // Past 13 days — healthy behaviour + historical acknowledged alerts
    for (int daysAgo = _daysOfHistory - 1; daysAgo >= 1; daysAgo--) {
      final date = _dayStart(today.subtract(Duration(days: daysAgo)));
      final lastIds = <String, String>{};

      for (final a in _animalDefs) {
        lastIds[a.id] = await _insertDayClassifications(
          animalId: a.id,
          date: date,
          distribution: _normal,
        );
      }

      // Day 10: Rosie — low feeding (resolved)
      if (daysAgo == 10) {
        await _insertAlert(
          animalId: 'demo-animal-003',
          classificationId: lastIds['demo-animal-003']!,
          alertType: AlertType.lowFeeding,
          severity: AlertSeverity.high,
          message:
              'Rosie spent only 3.8% grazing on ${_formatDate(date)} — '
              'below the 5.0% minimum. Resolved after pasture rotation.',
          timestamp: date.add(const Duration(hours: 18)),
          isAcknowledged: 1,
        );
      }

      // Day 6: Bruno — low rumination (resolved)
      if (daysAgo == 6) {
        await _insertAlert(
          animalId: 'demo-animal-004',
          classificationId: lastIds['demo-animal-004']!,
          alertType: AlertType.lowRumination,
          severity: AlertSeverity.medium,
          message:
              'Bruno spent only 2.1% ruminating on ${_formatDate(date)} — '
              'below the 3.0% minimum. Monitored and resolved.',
          timestamp: date.add(const Duration(hours: 16)),
          isAcknowledged: 1,
        );
      }

      // Day 3: Max — excessive walking (resolved)
      if (daysAgo == 3) {
        await _insertAlert(
          animalId: 'demo-animal-007',
          classificationId: lastIds['demo-animal-007']!,
          alertType: AlertType.excessiveWalking,
          severity: AlertSeverity.medium,
          message:
              'Max spent 87.2% of ${_formatDate(date)} walking — '
              'above the 85.0% maximum. Fence checked, no issue found.',
          timestamp: date.add(const Duration(hours: 14)),
          isAcknowledged: 1,
        );
      }

      // Day 1: Cleo — low feeding (resolved)
      if (daysAgo == 1) {
        await _insertAlert(
          animalId: 'demo-animal-008',
          classificationId: lastIds['demo-animal-008']!,
          alertType: AlertType.lowFeeding,
          severity: AlertSeverity.high,
          message:
              'Cleo spent only 4.1% grazing on ${_formatDate(date)} — '
              'below the 5.0% minimum. Resolved after supplemental feeding.',
          timestamp: date.add(const Duration(hours: 20)),
          isAcknowledged: 1,
        );
      }
    }

    // Today — only seed windows that have actually elapsed since midnight.
    // windowInterval = 86400 / 288 = 300 s (one window every 5 min).
    final todayStart    = _dayStart(today);
    final secondsSoFar  = today.difference(todayStart).inSeconds;
    final todayWindows  = (secondsSoFar / 300).floor().clamp(1, _windowsPerDay);

    final lastIdsToday = <String, String>{};

    for (final a in _animalDefs) {
      final dist = switch (a.id) {
        'demo-animal-001' => _lowGraze,
        'demo-animal-002' => _lowRumin,
        'demo-animal-006' => _highWalking,
        _                 => _normal,
      };

      lastIdsToday[a.id] = await _insertDayClassifications(
        animalId: a.id,
        date: todayStart,
        distribution: dist,
        windowCount: todayWindows,
      );
    }

    // Only seed active alerts once at least 3 hours of monitoring have elapsed.
    // Timestamps are placed proportionally within the elapsed window so they
    // never appear in the future or at an implausibly early hour.
    final hoursElapsed = secondsSoFar / 3600.0;
    if (hoursElapsed >= 3) {
      final monitoredHrs = todayWindows * 10 / 3600.0;
      final monitoredLabel = '${monitoredHrs.toStringAsFixed(1)} hrs of monitoring';

      final bessieGrazingHrs = (3.0 / 100 * monitoredHrs).toStringAsFixed(1);
      final daisyRuminHrs    = (2.0 / 100 * monitoredHrs).toStringAsFixed(1);
      final miaWalkingHrs    = (85.0 / 100 * monitoredHrs).toStringAsFixed(1);

      // Spread alert timestamps across 60–80% of the elapsed day
      final bessieTs = todayStart.add(Duration(seconds: (secondsSoFar * 0.60).round()));
      final daisyTs  = todayStart.add(Duration(seconds: (secondsSoFar * 0.70).round()));
      final miaTs    = todayStart.add(Duration(seconds: (secondsSoFar * 0.80).round()));

      await _insertAlert(
        animalId: 'demo-animal-001',
        classificationId: lastIdsToday['demo-animal-001']!,
        alertType: AlertType.lowFeeding,
        severity: AlertSeverity.high,
        message:
            'Bessie has been feeding for only $bessieGrazingHrs hrs out of '
            '$monitoredLabel today.',
        timestamp: bessieTs,
        isAcknowledged: 0,
      );

      await _insertAlert(
        animalId: 'demo-animal-002',
        classificationId: lastIdsToday['demo-animal-002']!,
        alertType: AlertType.lowRumination,
        severity: AlertSeverity.medium,
        message:
            'Daisy has been ruminating for only $daisyRuminHrs hrs out of '
            '$monitoredLabel today.',
        timestamp: daisyTs,
        isAcknowledged: 0,
      );

      await _insertAlert(
        animalId: 'demo-animal-006',
        classificationId: lastIdsToday['demo-animal-006']!,
        alertType: AlertType.excessiveWalking,
        severity: AlertSeverity.medium,
        message:
            'Mia has been walking for $miaWalkingHrs hrs out of '
            '$monitoredLabel today — above the normal range.',
        timestamp: miaTs,
        isAcknowledged: 0,
      );
    }
  }

  // ── Insert helpers ──────────────────────────────────────────────────────

  Future<void> _insertPastoralist() =>
      _db.into(_db.pastoralist).insertOnConflictUpdate(
        PastoralistCompanion.insert(
          id: _pastoralistId,
          name: 'Demo Pastoralist',
          phoneNumber: '+254700000000',
          location: const Value('Kajiado County, Kenya'),
        ),
      );

  Future<void> _insertHerd() =>
      _db.into(_db.herd).insertOnConflictUpdate(
        HerdCompanion.insert(
          id: _herdId,
          name: 'Demo Herd A',
          size: _animalDefs.length,
          pastoralistId: _pastoralistId,
        ),
      );

  Future<void> _insertAnimals() async {
    for (final a in _animalDefs) {
      await _db.into(_db.animal).insertOnConflictUpdate(
        AnimalCompanion.insert(
          id: a.id,
          name: Value(a.name),
          species: a.species,
          herdId: _herdId,
          wearableId: Value(a.wearable),
        ),
      );
    }
  }

  /// Inserts up to [windowCount] classification records starting at 00:00 on [date].
  /// Defaults to [_windowsPerDay] for historical days; pass a smaller value for today.
  /// Returns the ID of the last inserted record (used as classificationId in alerts).
  Future<String> _insertDayClassifications({
    required String animalId,
    required DateTime date,
    required List<double> distribution,
    int windowCount = _windowsPerDay,
  }) async {
    final classes = _buildClassSequence(distribution, windowCount);
    final dayStart = date;
    String lastId = '';

    await _db.batch((batch) {
      for (int i = 0; i < classes.length; i++) {
        // Spread windows evenly across 24 hours
        final secondsOffset = (i * 86400 / _windowsPerDay).round();
        final windowStart = dayStart.add(Duration(seconds: secondsOffset));
        final windowEnd   = windowStart.add(const Duration(seconds: 10));
        final cls  = classes[i];
        final id   = _uuid.v4();
        final prob = _fakeProbs(cls);
        lastId = id;

        batch.insert(
          _db.behaviourClassification,
          BehaviourClassificationCompanion.insert(
            id: id,
            animalId: animalId,
            timestamp: windowEnd,
            behaviourClass: cls,
            confidence: prob[cls],
            windowStart: windowStart,
            windowEnd: windowEnd,
            probGrazing: prob[BehaviourClass.grazing],
            probRuminating: prob[BehaviourClass.ruminating],
            probStanding: prob[BehaviourClass.standing],
            probLying: prob[BehaviourClass.lying],
            probWalking: prob[BehaviourClass.walking],
            alertProcessed: const Value(true),
            synced: const Value(1),
          ),
        );
      }
    });

    return lastId;
  }

  Future<void> _insertAlert({
    required String animalId,
    required String classificationId,
    required String alertType,
    required String severity,
    required String message,
    required DateTime timestamp,
    required int isAcknowledged,
  }) =>
      _db.into(_db.distressAlert).insertOnConflictUpdate(
        DistressAlertCompanion.insert(
          id: _uuid.v4(),
          animalId: animalId,
          classificationId: classificationId,
          pastoralistId: _pastoralistId,
          alertType: alertType,
          message: message,
          severity: severity,
          timestamp: timestamp,
          isAcknowledged: Value(isAcknowledged),
          synced: const Value(1),
        ),
      );

  // ── Utility helpers ─────────────────────────────────────────────────────

  List<int> _buildClassSequence(List<double> distribution, [int windowCount = _windowsPerDay]) {
    final counts = distribution
        .map((p) => (p * windowCount).round())
        .toList();
    final diff = windowCount - counts.reduce((a, b) => a + b);
    counts[BehaviourClass.grazing] += diff;

    final seq = <int>[];
    for (int cls = 0; cls < counts.length; cls++) {
      seq.addAll(List.filled(counts[cls], cls));
    }
    seq.shuffle(_rng);
    return seq;
  }

  List<double> _fakeProbs(int cls) {
    final confidence = 0.70 + _rng.nextDouble() * 0.25;
    final remaining  = 1.0 - confidence;
    final raw = List.generate(5, (i) => i == cls ? 0.0 : _rng.nextDouble());
    final sum = raw.reduce((a, b) => a + b);
    return List.generate(5, (i) {
      return i == cls ? confidence : (raw[i] / sum) * remaining;
    });
  }

  DateTime _dayStart(DateTime d) => DateTime(d.year, d.month, d.day);

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
