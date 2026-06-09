// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distress_alert_dao.dart';

// ignore_for_file: type=lint
mixin _$DistressAlertDaoMixin on DatabaseAccessor<AppDatabase> {
  $PastoralistTable get pastoralist => attachedDatabase.pastoralist;
  $HerdTable get herd => attachedDatabase.herd;
  $AnimalTable get animal => attachedDatabase.animal;
  $BehaviourClassificationTable get behaviourClassification =>
      attachedDatabase.behaviourClassification;
  $DistressAlertTable get distressAlert => attachedDatabase.distressAlert;
  DistressAlertDaoManager get managers => DistressAlertDaoManager(this);
}

class DistressAlertDaoManager {
  final _$DistressAlertDaoMixin _db;
  DistressAlertDaoManager(this._db);
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
  $$DistressAlertTableTableManager get distressAlert =>
      $$DistressAlertTableTableManager(_db.attachedDatabase, _db.distressAlert);
}
