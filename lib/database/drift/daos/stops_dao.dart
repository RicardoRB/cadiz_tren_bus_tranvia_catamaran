import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/stops_table.dart';
import '../../../shared/models/enums.dart';

part 'stops_dao.g.dart';

@DriftAccessor(tables: [Stops])
class StopsDao extends DatabaseAccessor<AppDatabase> with _$StopsDaoMixin {
  StopsDao(super.db);

  Future<List<Stop>> getAllStops() => select(stops).get();
  Future<List<Stop>> getStopsByMode(TransportMode mode) =>
      (select(stops)..where((t) => t.transportMode.equalsValue(mode))).get();

  Future<Stop?> getStopById(String id) =>
      (select(stops)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertStop(Stop stop) =>
      into(stops).insert(stop, mode: InsertMode.insertOrReplace);

  Future<List<Stop>> getStopsNear(
    double lat,
    double lon,
    double radiusInKm,
  ) async {
    // Basic bounding box filter first (approximate)
    // 1 degree lat is approx 111km
    final latDelta = radiusInKm / 111.0;
    // 1 degree lon is approx 111 * cos(lat) km
    // For Cadiz (lat ~36.5), cos(36.5) ~ 0.8
    final lonDelta = radiusInKm / (111.0 * 0.8);

    final query =
        select(stops)
          ..where(
            (t) =>
                t.lat.isBetweenValues(lat - latDelta, lat + latDelta) &
                t.lon.isBetweenValues(lon - lonDelta, lon + lonDelta),
          );

    return query.get();
  }
}
