// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_times_dao.dart';

// ignore_for_file: type=lint
mixin _$StopTimesDaoMixin on DatabaseAccessor<AppDatabase> {
  $OperatorsTable get operators => attachedDatabase.operators;
  $RoutesTable get routes => attachedDatabase.routes;
  $TripsTable get trips => attachedDatabase.trips;
  $StopsTable get stops => attachedDatabase.stops;
  $StopTimesTable get stopTimes => attachedDatabase.stopTimes;
  StopTimesDaoManager get managers => StopTimesDaoManager(this);
}

class StopTimesDaoManager {
  final _$StopTimesDaoMixin _db;
  StopTimesDaoManager(this._db);
  $$OperatorsTableTableManager get operators =>
      $$OperatorsTableTableManager(_db.attachedDatabase, _db.operators);
  $$RoutesTableTableManager get routes =>
      $$RoutesTableTableManager(_db.attachedDatabase, _db.routes);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db.attachedDatabase, _db.trips);
  $$StopsTableTableManager get stops =>
      $$StopsTableTableManager(_db.attachedDatabase, _db.stops);
  $$StopTimesTableTableManager get stopTimes =>
      $$StopTimesTableTableManager(_db.attachedDatabase, _db.stopTimes);
}
