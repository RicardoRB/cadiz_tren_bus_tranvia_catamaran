import 'package:drift/drift.dart';
import '../connection/connection.dart' if (dart.library.html) '../connection/web.dart' if (dart.library.io) '../connection/native.dart' as impl;

import 'tables/operators_table.dart';
import 'tables/stops_table.dart';
import 'tables/routes_table.dart';
import 'tables/trips_table.dart';
import 'tables/stop_times_table.dart';

import 'daos/operators_dao.dart';
import 'daos/stops_dao.dart';
import 'daos/routes_dao.dart';
import 'daos/trips_dao.dart';
import 'daos/stop_times_dao.dart';

import '../../shared/models/enums.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Operators,
    Stops,
    Routes,
    Trips,
    StopTimes,
  ],
  daos: [
    OperatorsDao,
    StopsDao,
    RoutesDao,
    TripsDao,
    StopTimesDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? impl.connect());

  @override
  int get schemaVersion => 1;
}
