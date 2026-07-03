// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes_dao.dart';

// ignore_for_file: type=lint
mixin _$RoutesDaoMixin on DatabaseAccessor<AppDatabase> {
  $OperatorsTable get operators => attachedDatabase.operators;
  $RoutesTable get routes => attachedDatabase.routes;
  $StopsTable get stops => attachedDatabase.stops;
  $TripsTable get trips => attachedDatabase.trips;
  $StopTimesTable get stopTimes => attachedDatabase.stopTimes;
  RoutesDaoManager get managers => RoutesDaoManager(this);
}

class RoutesDaoManager {
  final _$RoutesDaoMixin _db;
  RoutesDaoManager(this._db);
  $$OperatorsTableTableManager get operators =>
      $$OperatorsTableTableManager(_db.attachedDatabase, _db.operators);
  $$RoutesTableTableManager get routes =>
      $$RoutesTableTableManager(_db.attachedDatabase, _db.routes);
  $$StopsTableTableManager get stops =>
      $$StopsTableTableManager(_db.attachedDatabase, _db.stops);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db.attachedDatabase, _db.trips);
  $$StopTimesTableTableManager get stopTimes =>
      $$StopTimesTableTableManager(_db.attachedDatabase, _db.stopTimes);
}
