import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/stop_times_table.dart';
import '../../../shared/models/enums.dart';

part 'stop_times_dao.g.dart';

@DriftAccessor(tables: [StopTimes])
class StopTimesDao extends DatabaseAccessor<AppDatabase> with _$StopTimesDaoMixin {
  StopTimesDao(super.db);

  Future<List<StopTime>> getStopTimesForTrip(String tripId) => 
    (select(stopTimes)..where((t) => t.tripId.equals(tripId))..orderBy([(t) => OrderingTerm(expression: t.sequence)])).get();

  Future<List<StopTime>> getStopTimesByStopAndDay(String stopId, DayType dayType) =>
    (select(stopTimes)..where((t) => t.stopId.equals(stopId) & t.dayType.equalsValue(dayType))..orderBy([(t) => OrderingTerm(expression: t.arrivalTime)])).get();

  Future<List<StopTime>> getUpcomingStopTimesByStopAndDay(String stopId, DayType dayType, String time) =>
    (select(stopTimes)
      ..where((t) => t.stopId.equals(stopId) & t.dayType.equalsValue(dayType) & t.arrivalTime.isBiggerOrEqualValue(time))
      ..orderBy([(t) => OrderingTerm(expression: t.arrivalTime)]))
    .get();

  Future<int> insertStopTime(StopTime stopTime) => into(stopTimes).insert(stopTime, mode: InsertMode.insertOrReplace);
}
