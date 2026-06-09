// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'behaviour_classification_dao.dart';

// ignore_for_file: type=lint
mixin _$BehaviourClassificationDaoMixin on DatabaseAccessor<AppDatabase> {
  $PastoralistTable get pastoralist => attachedDatabase.pastoralist;
  $HerdTable get herd => attachedDatabase.herd;
  $AnimalTable get animal => attachedDatabase.animal;
  $BehaviourClassificationTable get behaviourClassification =>
      attachedDatabase.behaviourClassification;
  BehaviourClassificationDaoManager get managers =>
      BehaviourClassificationDaoManager(this);
}

class BehaviourClassificationDaoManager {
  final _$BehaviourClassificationDaoMixin _db;
  BehaviourClassificationDaoManager(this._db);
  $$PastoralistTableTableManager get pastoralist =>
      $$PastoralistTableTableManager(_db.attachedDatabase, _db.pastoralist);
  $$HerdTableTableManager get herd =>
      $$HerdTableTableManager(_db.attachedDatabase, _db.herd);
  $$AnimalTableTableManager get animal =>
      $$AnimalTableTableManager(_db.attachedDatabase, _db.animal);
  $$BehaviourClassificationTableTableManager get behaviourClassification =>
      $$BehaviourClassificationTableTableManager(
        _db.attachedDatabase,
        _db.behaviourClassification,
      );
}
