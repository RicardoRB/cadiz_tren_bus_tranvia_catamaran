import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/stop_times_table.dart';
import '../../../shared/models/enums.dart';

import '../tables/trips_table.dart';

part 'stop_times_dao.g.dart';

@DriftAccessor(tables: [StopTimes, Trips])
class StopTimesDao extends DatabaseAccessor<AppDatabase>
    with _$StopTimesDaoMixin {
  StopTimesDao(super.db);

  Future<List<StopTime>> getStopTimesForTrip(String tripId) =>
      (select(stopTimes)
            ..where((t) => t.tripId.equals(tripId))
            ..orderBy([(t) => OrderingTerm(expression: t.sequence)]))
          .get();

  Future<List<StopTime>> getStopTimesByStopAndDay(
    String stopId,
    DayType dayType,
  ) =>
      (select(stopTimes)
            ..where(
              (t) => t.stopId.equals(stopId) & t.dayType.equalsValue(dayType),
            )
            ..orderBy([(t) => OrderingTerm(expression: t.arrivalTime)]))
          .get();

  Future<List<StopTime>> getUpcomingStopTimesByStopAndDay(
    String stopId,
    DayType dayType,
    String time,
  ) =>
      (select(stopTimes)
            ..where(
              (t) =>
                  t.stopId.equals(stopId) &
                  t.dayType.equalsValue(dayType) &
                  t.arrivalTime.isBiggerOrEqualValue(time),
            )
            ..orderBy([(t) => OrderingTerm(expression: t.arrivalTime)]))
          .get();

  Future<StopTime?> getNextDeparture(
    String stopId,
    String routeId,
    Direction direction,
    DayType dayType,
    String time,
  ) {
    final query =
        select(
            stopTimes,
          ).join([innerJoin(trips, trips.id.equalsExp(stopTimes.tripId))])
          ..where(
            stopTimes.stopId.equals(stopId) &
                trips.routeId.equals(routeId) &
                trips.direction.equalsValue(direction) &
                stopTimes.dayType.equalsValue(dayType) &
                stopTimes.arrivalTime.isBiggerOrEqualValue(time),
          )
          ..orderBy([OrderingTerm(expression: stopTimes.arrivalTime)])
          ..limit(1);

    return query.map((row) => row.readTable(stopTimes)).getSingleOrNull();
  }

  Future<int> insertStopTime(StopTime stopTime) =>
      into(stopTimes).insert(stopTime, mode: InsertMode.insertOrReplace);
}
