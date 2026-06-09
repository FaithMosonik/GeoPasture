import 'package:drift/drift.dart';

import '../../../database/app_database.dart';
import '../../../database/tables/behaviour_classification.dart';

part 'behaviour_classification_dao.g.dart';

@DriftAccessor(tables: [BehaviourClassification])
class BehaviourClassificationDao extends DatabaseAccessor<AppDatabase>
    with _$BehaviourClassificationDaoMixin {
  BehaviourClassificationDao(super.db);

  Future<void> insertClassification(
    BehaviourClassificationCompanion entry,
  ) =>
      into(behaviourClassification).insert(entry);

  Future<List<BehaviourClassificationData>> getByAnimalAndDateRange(
    String animalId,
    DateTime start,
    DateTime end,
  ) =>
      (select(behaviourClassification)
            ..where(
              (c) =>
                  c.animalId.equals(animalId) &
                  c.windowStart.isBetweenValues(start, end),
            ))
          .get();

  Future<List<BehaviourClassificationData>> getUnsynced() =>
      (select(behaviourClassification)
            ..where((c) => c.synced.equals(0)))
          .get();

  Future<void> markAlertProcessed(String id) =>
      (update(behaviourClassification)..where((c) => c.id.equals(id))).write(
        const BehaviourClassificationCompanion(
          alertProcessed: Value(true),
        ),
      );
}
