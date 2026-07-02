// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operators_dao.dart';

// ignore_for_file: type=lint
mixin _$OperatorsDaoMixin on DatabaseAccessor<AppDatabase> {
  $OperatorsTable get operators => attachedDatabase.operators;
  OperatorsDaoManager get managers => OperatorsDaoManager(this);
}

class OperatorsDaoManager {
  final _$OperatorsDaoMixin _db;
  OperatorsDaoManager(this._db);
  $$OperatorsTableTableManager get operators =>
      $$OperatorsTableTableManager(_db.attachedDatabase, _db.operators);
}
