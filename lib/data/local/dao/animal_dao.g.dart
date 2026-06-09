// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_dao.dart';

// ignore_for_file: type=lint
mixin _$AnimalDaoMixin on DatabaseAccessor<AppDatabase> {
  $PastoralistTable get pastoralist => attachedDatabase.pastoralist;
  $HerdTable get herd => attachedDatabase.herd;
  $AnimalTable get animal => attachedDatabase.animal;
  AnimalDaoManager get managers => AnimalDaoManager(this);
}

class AnimalDaoManager {
  final _$AnimalDaoMixin _db;
  AnimalDaoManager(this._db);
  $$PastoralistTableTableManager get pastoralist =>
      $$PastoralistTableTableManager(_db.attachedDatabase, _db.pastoralist);
  $$HerdTableTableManager get herd =>
      $$HerdTableTableManager(_db.attachedDatabase, _db.herd);
  $$AnimalTableTableManager get animal =>
      $$AnimalTableTableManager(_db.attachedDatabase, _db.animal);
}
