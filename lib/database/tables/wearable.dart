import 'package:drift/drift.dart';
import 'animal.dart';

/// Physical sensor devices (accelerometer collars/tags) attached to animals.
/// Owned by: Lynn (sync module)
class Wearable extends Table {
  /// Device serial number — used as primary key
  TextColumn get id => text()();

  /// Nullable until the device is assigned to an animal
  TextColumn get animalId =>
      text().nullable().references(Animal, #id)();

  /// Accelerometer sampling rate in Hz — default 10Hz
  /// At 10Hz, 100 samples = exactly 10 seconds (one TFLite window)
  IntColumn get sampleRate => integer().withDefault(const Constant(10))();

  /// Battery level as a fraction: 0.0 (empty) to 1.0 (full)
  RealColumn get batteryLevel => real().nullable()();

  /// Timestamp of last successful Bluetooth sync with the phone
  DateTimeColumn get lastSeen => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
