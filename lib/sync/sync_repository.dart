import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../database/tables/sync_log.dart';

/// Handles all local SQLite read/write operations needed by the sync engine.
/// This is the only class that should directly query the DB for sync purposes.
class SyncRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  SyncRepository(this._db);

  // ── BEHAVIOUR CLASSIFICATION ───────────────────────────────────────────────

  /// Returns all behaviour classification records that have not yet
  /// been uploaded to Firestore, in batches of [batchSize].
  Future<List<BehaviourClassificationData>> getUnsyncedBehaviourClassifications({
    int batchSize = 50,
  }) async {
    return (_db.select(_db.behaviourClassification)
          ..where((t) => t.synced.equals(0))
          ..limit(batchSize))
        .get();
  }

  /// Marks a list of behaviour classification records as synced.
  /// Called after a successful Firestore upload.
  Future<void> markBehaviourClassificationsSynced(List<String> ids) async {
    await (_db.update(_db.behaviourClassification)
          ..where((t) => t.id.isIn(ids)))
        .write(const BehaviourClassificationCompanion(
          synced: Value(1),
        ));
  }

  // ── DISTRESS ALERT ─────────────────────────────────────────────────────────

  /// Returns all distress alert records that have not yet been uploaded
  /// to Firestore, in batches of [batchSize].
  Future<List<DistressAlertData>> getUnsyncedDistressAlerts({
    int batchSize = 50,
  }) async {
    return (_db.select(_db.distressAlert)
          ..where((t) => t.synced.equals(0))
          ..limit(batchSize))
        .get();
  }

  /// Marks a list of distress alert records as synced.
  /// Called after a successful Firestore upload.
  Future<void> markDistressAlertsSynced(List<String> ids) async {
    await (_db.update(_db.distressAlert)
          ..where((t) => t.id.isIn(ids)))
        .write(const DistressAlertCompanion(
          synced: Value(1),
        ));
  }

  // ── PASTURE MAP ────────────────────────────────────────────────────────────

  /// Upserts a pasture map record downloaded from Firestore into local SQLite.
  /// If the record already exists, it is replaced with the latest cloud data.
  Future<void> upsertPastureMap(PastureMapCompanion map) async {
    await _db.into(_db.pastureMap).insertOnConflictUpdate(map);
  }

  /// Returns the timestamp of the most recently cached pasture map.
  /// Used to fetch only newer records from Firestore (delta download).
  Future<DateTime?> getLatestPastureMapTimestamp() async {
    final query = _db.select(_db.pastureMap)
      ..orderBy([(t) => OrderingTerm.desc(t.generatedAt)])
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.generatedAt;
  }

  // ── SYNC LOG ───────────────────────────────────────────────────────────────

  /// Creates a new sync log entry when a sync attempt starts.
  Future<String> createSyncLog({
    required String recordId,
    required String tableName,
  }) async {
    final id = _uuid.v4();
    await _db.into(_db.syncLog).insert(SyncLogCompanion(
          id: Value(id),
          recordId: Value(recordId),
          targetTable: Value(tableName),
          status: const Value(SyncStatus.pending),
          createdAt: Value(DateTime.now()),
        ));
    return id;
  }

  /// Updates a sync log entry after a sync attempt completes.
  Future<void> updateSyncLog({
    required String id,
    required String status,
    int recordsUploaded = 0,
    int recordsDownloaded = 0,
    bool incrementRetry = false,
  }) async {
    final existing = await (_db.select(_db.syncLog)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();

    if (existing == null) return;

    await (_db.update(_db.syncLog)..where((t) => t.id.equals(id))).write(
      SyncLogCompanion(
        status: Value(status),
        syncTime: Value(DateTime.now()),
        recordsUploaded: Value(recordsUploaded),
        recordsDownloaded: Value(recordsDownloaded),
        retryCount: Value(
          incrementRetry ? existing.retryCount + 1 : existing.retryCount,
        ),
      ),
    );
  }

  // ── CLEANUP ────────────────────────────────────────────────────────────────

  /// Deletes behaviour classification records older than [days] days
  /// that have already been synced to Firestore.
  /// NEVER deletes unsynced records regardless of age.
  Future<int> pruneOldBehaviourClassifications({int days = 30}) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (_db.delete(_db.behaviourClassification)
          ..where((t) =>
              t.windowEnd.isSmallerOrEqualValue(cutoff) &
              t.synced.equals(1)))
        .go();
  }

  /// Deletes distress alert records older than [days] days
  /// that have already been synced to Firestore.
  /// NEVER deletes unsynced records regardless of age.
  Future<int> pruneOldDistressAlerts({int days = 30}) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (_db.delete(_db.distressAlert)
          ..where((t) =>
              t.timestamp.isSmallerOrEqualValue(cutoff) &
              t.synced.equals(1)))
        .go();
  }

  /// Returns counts of pending unsynced records across all upload tables.
  /// Useful for showing sync status in the UI.
  Future<Map<String, int>> getPendingSyncCounts() async {
    final behaviourCount = await (_db.select(_db.behaviourClassification)
          ..where((t) => t.synced.equals(0)))
        .get()
        .then((r) => r.length);

    final alertCount = await (_db.select(_db.distressAlert)
          ..where((t) => t.synced.equals(0)))
        .get()
        .then((r) => r.length);

    return {
      'behaviour_classifications': behaviourCount,
      'distress_alerts': alertCount,
    };
  }
}
