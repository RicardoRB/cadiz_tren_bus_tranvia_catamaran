import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/routes_table.dart';
import '../../../shared/models/enums.dart';

part 'routes_dao.g.dart';

@DriftAccessor(tables: [Routes])
class RoutesDao extends DatabaseAccessor<AppDatabase> with _$RoutesDaoMixin {
  RoutesDao(AppDatabase db) : super(db);

  Future<List<Route>> getAllRoutes() => select(routes).get();
  Future<List<Route>> getRoutesByMode(TransportMode mode) => (select(routes)..where((t) => t.transportMode.equalsValue(mode))).get();
  Future<int> insertRoute(Route route) => into(routes).insert(route, mode: InsertMode.insertOrReplace);
}
