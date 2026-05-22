import 'package:drift/drift.dart';
import 'herd.dart';

/// Individual animals within a herd.
/// Owned by: Lynn (sync module)
class Animal extends Table {
  TextColumn get id => text()();

  /// Optional tag name e.g. "Bessie"
  TextColumn get name => text().nullable()();

  /// e.g. "cattle", "camel", "goat"
  TextColumn get species => text()();

  TextColumn get herdId => text().references(Herd, #id)();

  /// Nullable — only set when a wearable device is attached
  TextColumn get wearableId => text().nullable()();

  /// Tropical Livestock Unit weight:
  /// cattle = 1.0, camel = 1.4, goat = 0.1
  RealColumn get tluValue => real().withDefault(const Constant(1.0))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
