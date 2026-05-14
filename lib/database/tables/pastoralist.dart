import 'package:drift/drift.dart';

/// Stores the registered user of the app.
/// Owned by: Lynn (sync module)
class Pastoralist extends Table {
  /// UUID generated on registration
  TextColumn get id => text()();

  TextColumn get name => text()();

  /// Must be unique across all pastoralists
  TextColumn get phoneNumber => text().unique()();

  /// General region or county — not precise GPS
  TextColumn get location => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
