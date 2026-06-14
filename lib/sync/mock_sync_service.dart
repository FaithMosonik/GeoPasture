import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../database/tables/sync_log.dart';
import 'sync_repository.dart';

/// DEMO MOCK — Simulates Firestore sync without a real Firebase connection.
/// Replace with real Firestore calls in sync_manager.dart once Moses
/// provides google-services.json.
class MockSyncService {
  final AppDatabase _db;
  final SyncRepository _repository;
  final _uuid = const Uuid();

  MockSyncService({
    required AppDatabase db,
    required SyncRepository repository,
  })  : _db = db,
        _repository = repository;

  // ── INSERT TEST RECORDS ─────────────────────────────────────────────────

  /// Inserts 3 fake behaviour classification records into local SQLite.
  Future<void> insertTestRecords() async {
    final behaviours = [
      (label: 'Grazing',    index: 0, confidence: 0.94),
      (label: 'Ruminating', index: 1, confidence: 0.87),
      (label: 'Standing',   index: 2, confidence: 0.91),
    ];

    for (final b in behaviours) {
      final now = DateTime.now();
      await _db.into(_db.behaviourClassification).insert(
        BehaviourClassificationCompanion(
          id:             Value(_uuid.v4()),
          animalId:       const Value('demo-animal-001'),
          timestamp:      Value(now),
          behaviourClass: Value(b.index),
          confidence:     Value(b.confidence),
          windowStart:    Value(now.subtract(const Duration(seconds: 10))),
          windowEnd:      Value(now),
          probGrazing:    Value(b.index == 0 ? b.confidence : 0.02),
          probRuminating: Value(b.index == 1 ? b.confidence : 0.02),
          probStanding:   Value(b.index == 2 ? b.confidence : 0.02),
          probLying:      const Value(0.005),
          probWalking:    const Value(0.005),
          alertProcessed: const Value(false),
          synced:         const Value(0),
        ),
      );
      debugPrint('[MockSync] Inserted ${b.label} record locally.');
    }
  }

  // ── MOCK UPLOAD ─────────────────────────────────────────────────────────

  /// Simulates uploading unsynced records to Firestore.
  Future<int> mockUploadBehaviourClassifications() async {
    final records = await _repository.getUnsyncedBehaviourClassifications();
    if (records.isEmpty) return 0;

    final logId = await _repository.createSyncLog(
      recordId: 'mock_batch_${DateTime.now().millisecondsSinceEpoch}',
      tableName: 'BEHAVIOUR_CLASSIFICATION',
    );

    debugPrint('[MockSync] Uploading ${records.length} records...');
    await Future.delayed(const Duration(seconds: 2));

    await _repository.markBehaviourClassificationsSynced(
      records.map((r) => r.id).toList(),
    );

    await _repository.updateSyncLog(
      id: logId,
      status: SyncStatus.synced,
      recordsUploaded: records.length,
    );

    debugPrint('[MockSync] Upload complete — ${records.length} records synced.');
    return records.length;
  }

  // ── MOCK PASTURE MAP DOWNLOAD ───────────────────────────────────────────

  /// Simulates downloading pasture maps from Firestore.
  Future<void> mockDownloadPastureMaps() async {
    debugPrint('[MockSync] Downloading pasture maps...');
    await Future.delayed(const Duration(seconds: 2));

    final maps = [
      PastureMapCompanion(
        id:               const Value('pasture-map-001'),
        region:           const Value('Laikipia North Block A'),
        generatedAt:      Value(DateTime.now()),
        ndviScore:        const Value(0.72),
        condition:        const Value('good'),
        biomassKgPerHa:   const Value(1200.0),
        areaHa:           const Value(45.0),
        totalBiomassKg:   const Value(54000.0),
        carryingCapacity: const Value(38),
        durationDays:     const Value(21),
        tilePath:         const Value(null),
      ),
      PastureMapCompanion(
        id:               const Value('pasture-map-002'),
        region:           const Value('Laikipia South Block B'),
        generatedAt:      Value(DateTime.now()),
        ndviScore:        const Value(0.41),
        condition:        const Value('moderate'),
        biomassKgPerHa:   const Value(680.0),
        areaHa:           const Value(32.0),
        totalBiomassKg:   const Value(21760.0),
        carryingCapacity: const Value(18),
        durationDays:     const Value(12),
        tilePath:         const Value(null),
      ),
    ];

    for (final map in maps) {
      await _db.into(_db.pastureMap).insertOnConflictUpdate(map);
      debugPrint('[MockSync] Cached pasture map: ${map.region.value}');
    }
  }

  /// Returns all locally cached pasture maps.
  Future<List<PastureMapData>> getCachedPastureMaps() async {
    return _db.select(_db.pastureMap).get();
  }

  /// Returns count of records currently pending sync.
  Future<Map<String, int>> getPendingCounts() =>
      _repository.getPendingSyncCounts();
}