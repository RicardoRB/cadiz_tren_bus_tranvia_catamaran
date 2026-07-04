import 'dart:math';
import '../../../database/drift/app_database.dart';
import '../../../shared/models/enums.dart';
import '../../schedule/domain/day_type_resolver.dart';
import '../domain/nearby_stop_model.dart';
import 'package:drift/drift.dart';

class NearbyStopsRepository {
  final AppDatabase _db;

  NearbyStopsRepository(this._db);

  Future<List<NearbyStopModel>> getNearbyStopsWithNextDeparture({
    required double lat,
    required double lon,
    required double radiusInKm,
    required DateTime now,
  }) async {
    final dayType = resolveDayType(now);
    final timeString =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:00';

    final latDelta = radiusInKm / 111.0;
    final lonDelta = radiusInKm / (111.0 * cos(lat * pi / 180).abs());

    final stopsInBox =
        await (_db.select(_db.stops)..where(
              (t) =>
                  t.lat.isBetweenValues(lat - latDelta, lat + latDelta) &
                  t.lon.isBetweenValues(lon - lonDelta, lon + lonDelta),
            ))
            .get();

    final List<NearbyStopModel> results = [];

    for (final stop in stopsInBox) {
      final nextDeparture =
          await (_db.select(_db.stopTimes)
                ..where(
                  (t) =>
                      t.stopId.equals(stop.id) &
                      t.dayType.equalsValue(dayType) &
                      t.departureTime.isBiggerOrEqualValue(timeString),
                )
                ..orderBy([(t) => OrderingTerm(expression: t.departureTime)])
                ..limit(1))
              .getSingleOrNull();

      if (nextDeparture != null) {
        final distance = _calculateDistance(lat, lon, stop.lat, stop.lon);
        if (distance <= radiusInKm) {
          results.add(
            NearbyStopModel(
              id: stop.id,
              name: stop.name,
              lat: stop.lat,
              lon: stop.lon,
              transportMode: stop.transportMode,
              nextDeparture: nextDeparture.departureTime,
              distanceInKm: distance,
            ),
          );
        }
      }
    }

    results.sort((a, b) => a.distanceInKm.compareTo(b.distanceInKm));

    return results;
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const p = 0.017453292519943295;
    final a =
        0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
