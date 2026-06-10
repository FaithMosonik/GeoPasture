import 'package:drift/drift.dart';

import '../../../database/app_database.dart';
import '../../../database/tables/distress_alert.dart';

part 'distress_alert_dao.g.dart';

@DriftAccessor(tables: [DistressAlert])
class DistressAlertDao extends DatabaseAccessor<AppDatabase>
    with _$DistressAlertDaoMixin {
  DistressAlertDao(super.db);

  Future<void> insertAlert(DistressAlertCompanion entry) =>
      into(distressAlert).insert(entry);

  Future<List<DistressAlertData>> getUnacknowledgedAlerts() =>
      (select(distressAlert)..where((a) => a.isAcknowledged.equals(0))).get();

  Future<void> acknowledgeAlert(String id) =>
      (update(distressAlert)..where((a) => a.id.equals(id))).write(
        const DistressAlertCompanion(isAcknowledged: Value(1)),
      );

  Future<List<DistressAlertData>> getAllAlerts() =>
      (select(distressAlert)
            ..orderBy([(a) => OrderingTerm.desc(a.timestamp)]))
          .get();

  Future<bool> hasActiveAlert(String animalId, String alertType) async {
    final rows = await (select(distressAlert)
          ..where(
            (a) =>
                a.animalId.equals(animalId) &
                a.alertType.equals(alertType) &
                a.isAcknowledged.equals(0),
          ))
        .get();
    return rows.isNotEmpty;
  }

  Future<List<DistressAlertData>> getUnsynced() =>
      (select(distressAlert)..where((a) => a.synced.equals(0))).get();
}
