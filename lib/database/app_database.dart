import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/pastoralist.dart';
import 'tables/herd.dart';
import 'tables/animal.dart';
import 'tables/wearable.dart';
import 'tables/accelerometer_reading.dart';
import 'tables/behaviour_classification.dart';
import 'tables/distress_alert.dart';
import 'tables/pasture_map.dart';
import 'tables/sync_log.dart';

part 'app_database.g.dart';

/// Central local SQLite database for GeoPasture.
///
/// Table ownership:
///   Lynn    → Pastoralist, Herd, Animal, Wearable, SyncLog
///   Mosonik    → AccelerometerReading, BehaviourClassification, DistressAlert
///   Moses   → PastureMap (read-only cache, downloaded from Firestore)
///
/// Data flow:
///   Wearable → AccelerometerReading (buffer)
///            → TFLite inference
///            → BehaviourClassification (permanent record)
///            → Alert logic
///            → DistressAlert
///            → Lynn's sync engine → Firestore
///
///   Firestore (Moses' pipeline) → PastureMap (download only)
@DriftDatabase(tables: [
  // ── Lynn's tables ───────────────────────────────
  Pastoralist,
  Herd,
  Animal,
  Wearable,
  SyncLog,

  // ──Mosonik's tables (behaviour module) ──────────────
  AccelerometerReading,
  BehaviourClassification,
  DistressAlert,

  // ── Moses' table (pasture module — read-only) ───
  PastureMap,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Increment this whenever you change the schema.
  /// Each bump requires a corresponding migration in [migration].
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Add migration steps here when schemaVersion is bumped
          // e.g. if (from < 2) await m.addColumn(behaviourClassification, behaviourClassification.probLying);
        },
        beforeOpen: (details) async {
          // Enable foreign key enforcement — SQLite disables this by default
          await customStatement('PRAGMA foreign_keys = ON');

          // Enable WAL mode for better concurrent read/write performance
          // (inference service writes while alert logic reads)
          await customStatement('PRAGMA journal_mode = WAL');
        },
      );
}

/// Opens the SQLite database file from the device's documents directory.
QueryExecutor _openConnection() {
  return driftDatabase(name: 'geopasture');
}
