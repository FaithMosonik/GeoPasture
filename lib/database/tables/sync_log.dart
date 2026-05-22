import 'package:drift/drift.dart';

/// Sync status constants
abstract class SyncStatus {
  static const String pending = 'pending';
  static const String synced = 'synced';
  static const String failed = 'failed';
}

/// Tracks the sync status of every record going to or from Firestore.
/// This is Lynn's table — the behaviour module should never write to it
/// directly. Lynn's sync engine reads the `synced` flags on
/// BEHAVIOUR_CLASSIFICATION and DISTRESS_ALERT, then manages SYNC_LOG itself.
///
/// Owned by: Lynn (offline/sync module)
class SyncLog extends Table {
  TextColumn get id => text()();

  /// The UUID of the record being synced (from whichever table it belongs to)
  TextColumn get recordId => text()();

  /// Which table the record belongs to e.g. 'BEHAVIOUR_CLASSIFICATION'
  TextColumn get targetTable => text()();

  /// When the sync was last attempted
  DateTimeColumn get syncTime => dateTime().nullable()();

  /// One of SyncStatus constants: 'pending', 'synced', 'failed'
  TextColumn get status => text()();

  IntColumn get recordsUploaded =>
      integer().withDefault(const Constant(0))();

  IntColumn get recordsDownloaded =>
      integer().withDefault(const Constant(0))();

  /// Number of retry attempts — used for exponential backoff
  IntColumn get retryCount =>
      integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
