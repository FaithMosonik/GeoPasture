import 'sync_repository.dart';
import 'package:flutter/foundation.dart';

/// Runs daily via WorkManager to prune old synced records from local SQLite.
///
/// Rules:
///   - Only deletes records where synced = 1 (already uploaded to Firestore)
///   - Never deletes unsynced records regardless of age
///   - Default retention period: 30 days
///
/// Registered in WorkManager as a periodic task — see sync_manager.dart.
class CleanupJob {
  final SyncRepository _repository;
  final int retentionDays;

  CleanupJob({
    required SyncRepository repository,
    this.retentionDays = 30,
  }) : _repository = repository;

  /// Runs the full cleanup across all tables.
  /// Returns a summary of how many records were deleted.
  Future<CleanupResult> run() async {
    try {
      final behaviourDeleted = await _repository.pruneOldBehaviourClassifications(
        days: retentionDays,
      );

      final alertsDeleted = await _repository.pruneOldDistressAlerts(
        days: retentionDays,
      );

      final result = CleanupResult(
        behaviourClassificationsDeleted: behaviourDeleted,
        distressAlertsDeleted: alertsDeleted,
        ranAt: DateTime.now(),
        success: true,
      );

      debugPrint('[CleanupJob] Completed: '
          '${result.behaviourClassificationsDeleted} classifications, '
          '${result.distressAlertsDeleted} alerts deleted.');

      return result;
    } catch (e) {
      debugPrint('[CleanupJob] Failed: $e');
      return CleanupResult(
        behaviourClassificationsDeleted: 0,
        distressAlertsDeleted: 0,
        ranAt: DateTime.now(),
        success: false,
        error: e.toString(),
      );
    }
  }
}

/// Result returned by [CleanupJob.run()]
class CleanupResult {
  final int behaviourClassificationsDeleted;
  final int distressAlertsDeleted;
  final DateTime ranAt;
  final bool success;
  final String? error;

  const CleanupResult({
    required this.behaviourClassificationsDeleted,
    required this.distressAlertsDeleted,
    required this.ranAt,
    required this.success,
    this.error,
  });

  int get totalDeleted =>
      behaviourClassificationsDeleted + distressAlertsDeleted;
}
