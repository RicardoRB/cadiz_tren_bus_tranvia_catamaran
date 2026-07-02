import '../../../database/drift/app_database.dart';
import '../../../database/drift/daos/routes_dao.dart';
import '../../../shared/models/domain/route.dart';
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

  RouteModel _mapToDomain(Route route) {
    return RouteModel(
      id: route.id,
      name: route.name,
      operatorId: route.operatorId,
      transportMode: route.transportMode,
      colorHex: route.colorHex,
    );
  }
}
