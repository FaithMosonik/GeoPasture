import 'package:drift/drift.dart';
import 'wearable.dart';

/// Raw accelerometer readings streamed from the wearable device.
///
/// This is a SHORT-LIVED buffer — records are pruned immediately after
/// the TFLite inference service processes them into a BEHAVIOUR_CLASSIFICATION.
/// At 10Hz, 100 readings accumulate in exactly 10 seconds (one inference window).
///
/// Owned by: You (behaviour module)
class AccelerometerReading extends Table {
  TextColumn get id => text()();

  TextColumn get wearableId =>
      text().references(Wearable, #id)();

  DateTimeColumn get timestamp => dateTime()();

  /// Accelerometer X-axis reading in m/s²
  RealColumn get xAxis => real()();

  /// Accelerometer Y-axis reading in m/s²
  RealColumn get yAxis => real()();

  /// Accelerometer Z-axis reading in m/s²
  RealColumn get zAxis => real()();

  /// 0 = pending inference, 1 = processed and safe to prune
  IntColumn get processed => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
