import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'routes_provider.dart';
import '../../../../shared/models/domain/route.dart';
import '../../../../shared/models/enums.dart';

part 'lines_list_provider.g.dart';

@riverpod
Future<List<RouteModel>> filteredRoutes(Ref ref, TransportMode mode, {String? searchQuery, String? operatorId}) async {
  final repository = ref.watch(routesRepositoryProvider);
  final allRoutes = await repository.getRoutesByMode(mode);

  return allRoutes.where((route) {
    final matchesQuery = searchQuery == null ||
        route.name.toLowerCase().contains(searchQuery.toLowerCase());
    final matchesOperator = operatorId == null || route.operatorId == operatorId;
    return matchesQuery && matchesOperator;
  }).toList();
}

@riverpod
Future<List<String>> modeOperators(Ref ref, TransportMode mode) async {
  final repository = ref.watch(routesRepositoryProvider);
  final routes = await repository.getRoutesByMode(mode);
  return routes.map((r) => r.operatorId).toSet().toList();
}
