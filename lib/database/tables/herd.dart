import 'package:drift/drift.dart';
import 'pastoralist.dart';

/// A pastoralist can manage one or more herds.
/// Owned by: Lynn (sync module)
class Herd extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  /// Total number of animals in the herd
  IntColumn get size => integer()();

  TextColumn get pastoralistId =>
      text().references(Pastoralist, #id)();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
