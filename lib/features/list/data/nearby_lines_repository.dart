import '../../../database/drift/app_database.dart';
import '../../../database/drift/daos/routes_dao.dart';
import '../../../database/drift/daos/stop_times_dao.dart';
import '../../../shared/models/domain/route.dart';
import '../../../shared/utils/distance.dart';
import '../../schedule/domain/day_type_resolver.dart';
import '../domain/nearby_line_entry.dart';
import '../../stops/data/stops_repository.dart';

class NearbyLinesRepository {
  final StopsRepository _stopsRepository;
  final RoutesDao _routesDao;
  final StopTimesDao _stopTimesDao;

  NearbyLinesRepository({
    required StopsRepository stopsRepository,
    required RoutesDao routesDao,
    required StopTimesDao stopTimesDao,
  }) : _stopsRepository = stopsRepository,
       _routesDao = routesDao,
       _stopTimesDao = stopTimesDao;

  Future<List<NearbyLineEntry>> getNearbyLines(
    double lat,
    double lon, {
    double radioKm = 2,
  }) async {
    final now = DateTime.now();
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final dayType = resolveDayType(now);

    final nearbyStops = await _stopsRepository.getStopsNear(lat, lon, radioKm);

    final List<NearbyLineEntry> entries = [];

    for (final stop in nearbyStops) {
      final distance = calcularDistancia(lat, lon, stop.lat, stop.lon);
      final routesWithDir = await _routesDao.getRoutesForStop(stop.id);

      for (final rd in routesWithDir) {
        final nextDeparture = await _stopTimesDao.getNextDeparture(
          stop.id,
          rd.route.id,
          rd.direction,
          dayType,
          timeStr,
        );

        entries.add(
          NearbyLineEntry(
            stop: stop,
            route: _mapRouteToDomain(rd.route),
            distanciaMetros: distance,
            proximaSalida: nextDeparture?.arrivalTime,
            direction: rd.direction,
          ),
        );
      }
    }

    // Ordenar por distancia (más cercano primero)
    entries.sort((a, b) => a.distanciaMetros.compareTo(b.distanciaMetros));

    return entries;
  }

  RouteModel _mapRouteToDomain(Route route) {
    return RouteModel(
      id: route.id,
      name: route.name,
      operatorId: route.operatorId,
      transportMode: route.transportMode,
      colorHex: route.colorHex,
    );
  }
}
