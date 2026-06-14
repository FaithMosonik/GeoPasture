import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import '../database/app_database.dart';
import '../database/tables/sync_log.dart';
import 'connectivity_monitor.dart';
import 'retry_handler.dart';
import 'sync_repository.dart';
import 'cleanup_job.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ── WorkManager task names ─────────────────────────────────────────────────
const String kSyncTaskName = 'geopasture_sync';
const String kCleanupTaskName = 'geopasture_cleanup';

/// Called by WorkManager in the background isolate.
/// Register this as the callback in main.dart:
///   Workmanager().initialize(callbackDispatcher);
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case kCleanupTaskName:
        final db = AppDatabase();
        final repo = SyncRepository(db);
        final job = CleanupJob(repository: repo);
        await job.run();
        await db.close();
        return true;
      default:
        return false;
    }
  });
}

/// Orchestrates the full sync lifecycle:
///   1. Listens for connectivity restoration via [ConnectivityMonitor]
///   2. Uploads unsynced records to Firestore in batches with retry logic
///   3. Downloads latest pasture maps from Firestore
///   4. Updates [SyncLog] with results including retry counts
///   5. Schedules daily cleanup via WorkManager
class SyncManager {
  final SyncRepository _repository;
  final ConnectivityMonitor _connectivity;
  final RetryHandler _retry;

  StreamSubscription<NetworkStatus>? _connectivitySubscription;
  bool _isSyncing = false;

  SyncManager({
    required SyncRepository repository,
    required ConnectivityMonitor connectivity,
    RetryHandler? retryHandler,
  })  : _repository = repository,
        _connectivity = connectivity,
        _retry = retryHandler ?? const RetryHandler();

  /// Initialises the sync manager.
  Future<void> init() async {
    await _connectivity.start();

    _connectivitySubscription =
        _connectivity.onConnectivityRestored.listen((_) async {
      await _runSync();
    });

    await Workmanager().registerPeriodicTask(
      kCleanupTaskName,
      kCleanupTaskName,
      frequency: const Duration(hours: 24),
      constraints: Constraints(
        networkType: NetworkType.notRequired,
      ),
    );

    if (_connectivity.isOnline) {
      await _runSync();
    }
  }

  /// Disposes resources. Call when the app is terminating.
  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _connectivity.stop();
  }

  // ── SYNC ORCHESTRATION ──────────────────────────────────────────────────

  Future<void> _runSync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      await _uploadBehaviourClassifications();
      await _uploadDistressAlerts();
      await _downloadPastureMaps();
    } catch (e) {
      if (e is! UnimplementedError) {
        debugPrint('[SyncManager] Sync failed: $e');
      }
    } finally {
      _isSyncing = false;
    }
  }

  // ── UPLOAD: BEHAVIOUR CLASSIFICATIONS ───────────────────────────────────

  Future<void> _uploadBehaviourClassifications() async {
    final records = await _repository.getUnsyncedBehaviourClassifications();
    if (records.isEmpty) return;

    final logId = await _repository.createSyncLog(
      recordId: 'batch_${DateTime.now().millisecondsSinceEpoch}',
      tableName: 'BEHAVIOUR_CLASSIFICATION',
    );

    final success = await _retry.execute(
      operationName: 'UploadBehaviourClassifications',
      operation: () async {
        if (!await _connectivity.checkIsOnline()) return;

        // ── TODO: Replace this stub with actual Firestore upload ───────────
        // When Firestore is configured, uncomment the block below and
        // add: import 'package:cloud_firestore/cloud_firestore.dart';
        //
        final batch = FirebaseFirestore.instance.batch();
        for (final record in records) {
           final ref = FirebaseFirestore.instance
              .collection('behaviour_classifications')
              .doc(record.id);
           batch.set(ref, {
            'animal_id':       record.animalId,
           'behaviour_class': record.behaviourClass,
             'confidence':      record.confidence,
             'prob_grazing':    record.probGrazing,
            'prob_ruminating': record.probRuminating,
             'prob_standing':   record.probStanding,
             'prob_lying':      record.probLying,
             'prob_walking':    record.probWalking,
             'window_start':    record.windowStart.toIso8601String(),
             'window_end':      record.windowEnd.toIso8601String(),
             'timestamp':       record.timestamp.toIso8601String(),
           });
         }
         await batch.commit();
         await _repository.markBehaviourClassificationsSynced(
           records.map((r) => r.id).toList(),
         );
         await _repository.updateSyncLog(
           id: logId,
           status: SyncStatus.synced,
           recordsUploaded: records.length,
         );
        // ───────────────────────────────────────────────────────────────────

      
      },
      onRetry: (attempt, error) async {
        await _repository.updateSyncLog(
          id: logId,
          status: SyncStatus.failed,
          incrementRetry: true,
        );
      },
    );

    if (!success) {
      debugPrint(
        '[SyncManager] Behaviour classifications upload gave up after max retries.',
      );
    }
  }

  // ── UPLOAD: DISTRESS ALERTS ──────────────────────────────────────────────

  Future<void> _uploadDistressAlerts() async {
    final records = await _repository.getUnsyncedDistressAlerts();
    if (records.isEmpty) return;

    final logId = await _repository.createSyncLog(
      recordId: 'batch_${DateTime.now().millisecondsSinceEpoch}',
      tableName: 'DISTRESS_ALERT',
    );

    final success = await _retry.execute(
      operationName: 'UploadDistressAlerts',
      operation: () async {
        if (!await _connectivity.checkIsOnline()) return;

        
        // When Firestore is configured, uncomment the block below and
        // add: import 'package:cloud_firestore/cloud_firestore.dart';
      
         final batch = FirebaseFirestore.instance.batch();
         for (final record in records) {
           final ref = FirebaseFirestore.instance
               .collection('distress_alerts')
               .doc(record.id);
           batch.set(ref, {
             'animal_id':         record.animalId,
             'classification_id': record.classificationId,
             'pastoralist_id':    record.pastoralistId,
             'alert_type':        record.alertType,
             'message':           record.message,
             'severity':          record.severity,
             'timestamp':         record.timestamp.toIso8601String(),
             'is_acknowledged':   record.isAcknowledged,
           });
         }
         await batch.commit();
         await _repository.markDistressAlertsSynced(
           records.map((r) => r.id).toList(),
         );
         await _repository.updateSyncLog(
           id: logId,
           status: SyncStatus.synced,
           recordsUploaded: records.length,
         );
        

  
      },
      onRetry: (attempt, error) async {
        await _repository.updateSyncLog(
          id: logId,
          status: SyncStatus.failed,
          incrementRetry: true,
        );
      },
    );

    if (!success) {
      debugPrint(
        '[SyncManager] Distress alerts upload gave up after max retries.',
      );
    }
  }

  // ── DOWNLOAD: PASTURE MAPS ───────────────────────────────────────────────

  Future<void> _downloadPastureMaps() async {
    if (!await _connectivity.checkIsOnline()) return;

    final logId = await _repository.createSyncLog(
      recordId: 'pasture_map_download_${DateTime.now().millisecondsSinceEpoch}',
      tableName: 'PASTURE_MAP',
    );

    // ignore: unused_local_variable
    final latestCached = await _repository.getLatestPastureMapTimestamp();

    final success = await _retry.execute(
      operationName: 'DownloadPastureMaps',
      operation: () async {
      
        // When Firestore is configured, uncomment the block below and
        // add: import 'package:cloud_firestore/cloud_firestore.dart';
        
         Query query = FirebaseFirestore.instance.collection('pasture_maps');
         if (latestCached != null) {
           query = query.where('generated_at',
               isGreaterThan: latestCached.toIso8601String());
         }
         final snapshot = await query.get();
         for (final doc in snapshot.docs) {
           final data = doc.data();
           await _repository.upsertPastureMap(PastureMapCompanion(
             id:               Value(doc.id),
             region:           Value(data['region']),
             generatedAt:      Value(DateTime.parse(data['generated_at'])),
             ndviScore:        Value(data['ndvi_score']),
             condition:        Value(data['condition']),
             biomassKgPerHa:   Value(data['biomass_kg_per_ha']),
             areaHa:           Value(data['area_ha']),
             totalBiomassKg:   Value(data['total_biomass_kg']),
             carryingCapacity: Value(data['carrying_capacity']),
             durationDays:     Value(data['duration_days']),
             tilePath:         Value(data['tile_path']),
           ));
         }
         await _repository.updateSyncLog(
           id: logId,
           status: SyncStatus.synced,
           recordsDownloaded: snapshot.docs.length,
         );
      

      
      },
      onRetry: (attempt, error) async {
        await _repository.updateSyncLog(
          id: logId,
          status: SyncStatus.failed,
          incrementRetry: true,
        );
      },
    );

    if (!success) {
      debugPrint(
        '[SyncManager] Pasture map download gave up after max retries.',
      );
    }
  }

  // ── PUBLIC UTILITIES ─────────────────────────────────────────────────────

  /// Returns how many records are waiting to be synced.
  Future<Map<String, int>> getPendingSyncCounts() =>
      _repository.getPendingSyncCounts();

  /// Manually triggers a sync — e.g. from a "Sync Now" button in the UI.
  Future<void> syncNow() async {
    if (!await _connectivity.checkIsOnline()) return;
    await _runSync();
  }
}