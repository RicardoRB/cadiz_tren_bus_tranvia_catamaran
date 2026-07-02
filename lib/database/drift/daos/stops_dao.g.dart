// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stops_dao.dart';

// ignore_for_file: type=lint
mixin _$StopsDaoMixin on DatabaseAccessor<AppDatabase> {
  $OperatorsTable get operators => attachedDatabase.operators;
  $StopsTable get stops => attachedDatabase.stops;
  StopsDaoManager get managers => StopsDaoManager(this);
}

class StopsDaoManager {
  final _$StopsDaoMixin _db;
  StopsDaoManager(this._db);
  $$OperatorsTableTableManager get operators =>
      $$OperatorsTableTableManager(_db.attachedDatabase, _db.operators);
  $$StopsTableTableManager get stops =>
      $$StopsTableTableManager(_db.attachedDatabase, _db.stops);
}
