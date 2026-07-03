import '../../../database/drift/app_database.dart';
import '../../../database/drift/daos/routes_dao.dart';
import '../../../shared/models/domain/route.dart';
import '../../../shared/models/domain/stop.dart';
import '../../../shared/models/enums.dart';

class RoutesRepository {
  final RoutesDao _routesDao;

  RoutesRepository(this._routesDao);

  Future<List<RouteModel>> getAllRoutes() async {
    final routes = await _routesDao.getAllRoutes();
    return routes.map(_mapToDomain).toList();
  }

  Future<List<RouteModel>> getRoutesByMode(TransportMode mode) async {
    final routes = await _routesDao.getRoutesByMode(mode);
    return routes.map(_mapToDomain).toList();
  }

  Future<RouteModel?> getRouteById(String id) async {
    final route = await _routesDao.getRouteById(id);
    return route != null ? _mapToDomain(route) : null;
  }

  Future<List<StopModel>> getStopsForRoute(String routeId, Direction direction) async {
    final stops = await _routesDao.getStopsForRoute(routeId, direction);
    return stops.map(_mapStopToDomain).toList();
  }

  RouteModel _mapToDomain(Route route) {
    return RouteModel(
      id: route.id,
      name: route.name,
      operatorId: route.operatorId,
      transportMode: route.transportMode,
      colorHex: route.colorHex,
    );
  }

  StopModel _mapStopToDomain(Stop stop) {
    return StopModel(
      id: stop.id,
      name: stop.name,
      lat: stop.lat,
      lon: stop.lon,
      transportMode: stop.transportMode,
      operatorId: stop.operatorId,
    );
  }
}
