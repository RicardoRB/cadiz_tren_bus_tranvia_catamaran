import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'routes_provider.dart';
import '../../../../shared/models/domain/route.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../../../shared/models/enums.dart';

part 'line_detail_provider.g.dart';

@riverpod
Future<RouteModel?> routeDetail(Ref ref, String id) {
  return ref.watch(routesRepositoryProvider).getRouteById(id);
}

@riverpod
Future<List<StopModel>> routeStops(Ref ref, String id, Direction direction) {
  return ref.watch(routesRepositoryProvider).getStopsForRoute(id, direction);
}
