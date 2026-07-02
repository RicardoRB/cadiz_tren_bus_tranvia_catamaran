// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes_dao.dart';

// ignore_for_file: type=lint
mixin _$RoutesDaoMixin on DatabaseAccessor<AppDatabase> {
  $OperatorsTable get operators => attachedDatabase.operators;
  $RoutesTable get routes => attachedDatabase.routes;
  RoutesDaoManager get managers => RoutesDaoManager(this);
}

class RoutesDaoManager {
  final _$RoutesDaoMixin _db;
  RoutesDaoManager(this._db);
  $$OperatorsTableTableManager get operators =>
      $$OperatorsTableTableManager(_db.attachedDatabase, _db.operators);
  $$RoutesTableTableManager get routes =>
      $$RoutesTableTableManager(_db.attachedDatabase, _db.routes);
}
