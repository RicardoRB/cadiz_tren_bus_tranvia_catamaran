import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'routes_provider.dart';
import '../../../../shared/models/domain/route.dart';
import '../../../../shared/models/enums.dart';

part 'lines_list_provider.g.dart';

@riverpod
Future<List<RouteModel>> routesByMode(Ref ref, TransportMode mode) {
  final repository = ref.watch(routesRepositoryProvider);
  return repository.getRoutesByMode(mode);
}

@riverpod
Future<List<RouteModel>> filteredRoutes(Ref ref, TransportMode mode, {String? searchQuery, String? operatorId}) async {
  final allRoutes = await ref.watch(routesByModeProvider(mode).future);

  return allRoutes.where((route) {
    final matchesQuery = searchQuery == null ||
        route.name.toLowerCase().contains(searchQuery.toLowerCase());
    final matchesOperator = operatorId == null || route.operatorId == operatorId;
    return matchesQuery && matchesOperator;
  }).toList();
}

@riverpod
Future<List<String>> modeOperators(Ref ref, TransportMode mode) async {
  final routes = await ref.watch(routesByModeProvider(mode).future);
  return routes.map((r) => r.operatorId).toSet().toList();
}

@riverpod
Future<Map<String, String>> operatorsMap(Ref ref) async {
  final repository = ref.watch(operatorsRepositoryProvider);
  final operators = await repository.getAllOperators();
  return {for (var o in operators) o.id: o.name};
}
