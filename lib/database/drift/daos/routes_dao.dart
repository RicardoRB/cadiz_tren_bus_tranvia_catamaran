import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/routes_table.dart';
import '../tables/stops_table.dart';
import '../tables/stop_times_table.dart';
import '../tables/trips_table.dart';
import '../../../shared/models/enums.dart';

part 'routes_dao.g.dart';

class RouteWithDirection {
  final Route route;
  final Direction direction;

  RouteWithDirection(this.route, this.direction);
}

@DriftAccessor(tables: [Routes, Stops, StopTimes, Trips])
class RoutesDao extends DatabaseAccessor<AppDatabase> with _$RoutesDaoMixin {
  RoutesDao(super.db);

  Future<List<Route>> getAllRoutes() => select(routes).get();
  Future<List<Route>> getRoutesByMode(TransportMode mode) =>
      (select(routes)..where((t) => t.transportMode.equalsValue(mode))).get();

  Future<Route?> getRouteById(String id) =>
      (select(routes)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<RouteWithDirection>> getRoutesForStop(String stopId) {
    final query =
        select(routes).join([
            innerJoin(trips, trips.routeId.equalsExp(routes.id)),
            innerJoin(stopTimes, stopTimes.tripId.equalsExp(trips.id)),
          ])
          ..where(stopTimes.stopId.equals(stopId))
          ..groupBy([routes.id, trips.direction]);

    return query.map((row) {
      return RouteWithDirection(
        row.readTable(routes),
        row.readTable(trips).direction,
      );
    }).get();
  }

  Future<List<Stop>> getStopsForRoute(
    String routeId,
    Direction direction,
  ) async {
    // To avoid duplicates if there are multiple trips for the same route/direction
    // we take the stops from the first trip found for that route/direction.
    final firstTrip =
        await (select(attachedDatabase.trips)
              ..where(
                (t) =>
                    t.routeId.equals(routeId) &
                    t.direction.equalsValue(direction),
              )
              ..orderBy([(t) => OrderingTerm(expression: t.id)])
              ..limit(1))
            .getSingleOrNull();

    if (firstTrip == null) return [];

    return (select(attachedDatabase.stops).join([
            innerJoin(
              attachedDatabase.stopTimes,
              attachedDatabase.stopTimes.stopId.equalsExp(
                attachedDatabase.stops.id,
              ),
            ),
          ])
          ..where(attachedDatabase.stopTimes.tripId.equals(firstTrip.id))
          ..orderBy([
            OrderingTerm(expression: attachedDatabase.stopTimes.sequence),
          ]))
        .map((row) => row.readTable(attachedDatabase.stops))
        .get();
  }

  Future<int> insertRoute(Route route) =>
      into(routes).insert(route, mode: InsertMode.insertOrReplace);
}
