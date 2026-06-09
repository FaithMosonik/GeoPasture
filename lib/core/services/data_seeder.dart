import 'dart:math';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../database/app_database.dart';
import '../../database/tables/behaviour_classification.dart';
import '../../database/tables/distress_alert.dart';

/// Populates the local database with one week of realistic demo data.
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
    (id: 'demo-animal-005', name: 'Luna',   species: 'goat',   wearable: 'WBL-005'),
  ];

  // Windows per day per animal  (1 window = 10 s  →  500 windows ≈ 83 min)
  static const _windowsPerDay = 500;

  // Behaviour distributions — [grazing, ruminating, standing, lying, walking]
  static const _normal   = [0.40, 0.30, 0.20, 0.07, 0.03]; // healthy
  static const _lowGraze = [0.03, 0.30, 0.40, 0.25, 0.02]; // Bessie today  → HIGH alert
  static const _lowRumin = [0.40, 0.02, 0.30, 0.25, 0.03]; // Daisy today   → MEDIUM alert

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

    // Past 6 days — healthy behaviour + two historical acknowledged alerts
    for (int daysAgo = 6; daysAgo >= 1; daysAgo--) {
      final date = _dayStart(today.subtract(Duration(days: daysAgo)));
      final lastIds = <String, String>{}; // animalId → last classificationId

      for (final a in _animalDefs) {
        lastIds[a.id] = await _insertDayClassifications(
          animalId: a.id,
          date: date,
          distribution: _normal,
        );
      }

      // Day 4 ago: Rosie had a low-feeding episode (resolved, acknowledged)
      if (daysAgo == 4) {
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

      // Day 2 ago: Bruno had a low-rumination episode (resolved, acknowledged)
      if (daysAgo == 2) {
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
    }

    // Today — Bessie (low grazing) and Daisy (low rumination)
    final lastIdsToday = <String, String>{};

    for (final a in _animalDefs) {
      final dist = switch (a.id) {
        'demo-animal-001' => _lowGraze,
        'demo-animal-002' => _lowRumin,
        _                 => _normal,
      };

      lastIdsToday[a.id] = await _insertDayClassifications(
        animalId: a.id,
        date: _dayStart(today),
        distribution: dist,
      );
    }

    // Today's unacknowledged alerts
    await _insertAlert(
      animalId: 'demo-animal-001',
      classificationId: lastIdsToday['demo-animal-001']!,
      alertType: AlertType.lowFeeding,
      severity: AlertSeverity.high,
      message:
          'Bessie has spent only 3.0% of today grazing — below the 5.0% '
          'minimum. Check for illness or poor pasture access.',
      timestamp: today.subtract(const Duration(hours: 1)),
      isAcknowledged: 0,
    );

    await _insertAlert(
      animalId: 'demo-animal-002',
      classificationId: lastIdsToday['demo-animal-002']!,
      alertType: AlertType.lowRumination,
      severity: AlertSeverity.medium,
      message:
          'Daisy has spent only 2.0% of today ruminating — below the 3.0% '
          'minimum. This may indicate digestive issues.',
      timestamp: today.subtract(const Duration(minutes: 30)),
      isAcknowledged: 0,
    );
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

  /// Inserts [_windowsPerDay] classification records starting at 06:00 on [date].
  /// Returns the ID of the last inserted record (used as classificationId in alerts).
  Future<String> _insertDayClassifications({
    required String animalId,
    required DateTime date,
    required List<double> distribution,
  }) async {
    final classes = _buildClassSequence(distribution);
    final recordingStart = date.add(const Duration(hours: 6));
    String lastId = '';

    await _db.batch((batch) {
      for (int i = 0; i < classes.length; i++) {
        final windowStart = recordingStart.add(Duration(seconds: i * 10));
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

  /// Returns a shuffled list of [_windowsPerDay] class indices
  /// matching the given probability [distribution].
  List<int> _buildClassSequence(List<double> distribution) {
    final counts = distribution
        .map((p) => (p * _windowsPerDay).round())
        .toList();
    // Absorb rounding difference into the grazing bucket
    final diff = _windowsPerDay - counts.reduce((a, b) => a + b);
    counts[BehaviourClass.grazing] += diff;

    final seq = <int>[];
    for (int cls = 0; cls < counts.length; cls++) {
      seq.addAll(List.filled(counts[cls], cls));
    }
    seq.shuffle(_rng);
    return seq;
  }

  /// Returns a 5-element softmax-like probability vector dominated by [cls].
  List<double> _fakeProbs(int cls) {
    final confidence = 0.70 + _rng.nextDouble() * 0.25; // 0.70–0.95
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
