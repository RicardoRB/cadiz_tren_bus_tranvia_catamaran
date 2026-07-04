import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../../../shared/models/domain/route.dart';
import '../../../stops/presentation/providers/stops_provider.dart';
import '../../../lines/presentation/providers/routes_provider.dart';

part 'favorites_provider.g.dart';

@riverpod
class FavoriteStops extends _$FavoriteStops {
  static const _favoritesKey = 'favorite_stops';

  @override
  Set<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final favorites = prefs.getStringList(_favoritesKey);
    return (favorites ?? []).toSet();
  }

  Future<void> toggleFavorite(String stopId) async {
    final current = state.toSet();
    if (current.contains(stopId)) {
      current.remove(stopId);
    } else {
      current.add(stopId);
    }
    state = current;

    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(_favoritesKey, current.toList());
  }

  bool isFavorite(String stopId) {
    return state.contains(stopId);
  }
}

@riverpod
Future<List<StopModel>> favoriteStopsList(Ref ref) async {
  final favoriteIds = ref.watch(favoriteStopsProvider);
  if (favoriteIds.isEmpty) return [];

  final repository = ref.watch(stopsRepositoryProvider);

  final favoritesFutures = favoriteIds.map((id) => repository.getStopById(id));
  final results = await Future.wait(favoritesFutures);

  return results.whereType<StopModel>().toList();
}

@riverpod
class FavoriteLines extends _$FavoriteLines {
  static const _favoritesKey = 'favorite_lines';

  @override
  Set<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final favorites = prefs.getStringList(_favoritesKey);
    return (favorites ?? []).toSet();
  }

  Future<void> toggleFavorite(String routeId) async {
    final current = state.toSet();
    if (current.contains(routeId)) {
      current.remove(routeId);
    } else {
      current.add(routeId);
    }
    state = current;

    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(_favoritesKey, current.toList());
  }

  bool isFavorite(String routeId) {
    return state.contains(routeId);
  }
}

@riverpod
Future<List<RouteModel>> favoriteLinesList(Ref ref) async {
  final favoriteIds = ref.watch(favoriteLinesProvider);
  if (favoriteIds.isEmpty) return [];

  final repository = ref.watch(routesRepositoryProvider);

  final favoritesFutures = favoriteIds.map((id) => repository.getRouteById(id));
  final results = await Future.wait(favoritesFutures);

  return results.whereType<RouteModel>().toList();
}
