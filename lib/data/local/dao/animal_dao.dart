import 'package:drift/drift.dart';

import '../../../database/app_database.dart';
import '../../../database/tables/animal.dart';

part 'animal_dao.g.dart';

@DriftAccessor(tables: [Animal])
class AnimalDao extends DatabaseAccessor<AppDatabase> with _$AnimalDaoMixin {
  AnimalDao(super.db);

  Future<List<AnimalData>> getAnimalsByHerd(String herdId) =>
      (select(animal)..where((a) => a.herdId.equals(herdId))).get();

  Future<AnimalData?> getAnimalByWearableId(String wearableId) =>
      (select(animal)..where((a) => a.wearableId.equals(wearableId)))
          .getSingleOrNull();
}
