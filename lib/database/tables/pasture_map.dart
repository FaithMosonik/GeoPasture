import 'package:drift/drift.dart';

/// Pasture analysis data downloaded from Firestore and cached locally.
/// Moses' cloud pipeline computes all fields — this table is READ-ONLY
/// from the device's perspective. Nothing is ever written back to the cloud
/// from this table.
///
/// The device caches this data so the pastoralist can view pasture
/// conditions and carrying capacity while offline in the field.
///
/// Owned by: Moses (pasture module)
class PastureMap extends Table {
  TextColumn get id => text()();

  /// Zone or paddock name e.g. "Laikipia North Block A"
  TextColumn get region => text()();

  /// When Moses' satellite analysis pipeline last ran for this region
  DateTimeColumn get generatedAt => dateTime()();

  /// Normalised Difference Vegetation Index: 0.0 (bare) to 1.0 (dense)
  RealColumn get ndviScore => real()();

  /// Human-readable condition derived from NDVI: "good", "moderate", "poor"
  TextColumn get condition => text()();

  /// Dry matter biomass available per hectare (kg/ha)
  RealColumn get biomassKgPerHa => real()();

  /// Total area of the pasture zone in hectares
  RealColumn get areaHa => real()();

  /// Total available biomass = biomassKgPerHa × areaHa
  RealColumn get totalBiomassKg => real()();

  /// Maximum number of animals this pasture can sustain at current biomass
  IntColumn get carryingCapacity => integer().nullable()();

  /// Number of days the pasture can sustain the carrying capacity load
  IntColumn get durationDays => integer().nullable()();

  /// Local file system path to the cached MBTiles map file for offline rendering
  /// Null if map tiles have not been downloaded yet
  TextColumn get tilePath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
