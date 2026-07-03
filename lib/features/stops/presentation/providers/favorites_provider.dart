import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../shared/models/domain/stop.dart';
import 'stops_provider.dart';

part 'favorites_provider.g.dart';

@riverpod
class Favorites extends _$Favorites {
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
Future<List<StopModel>> favoriteStops(Ref ref) async {
  final favoriteIds = ref.watch(favoritesProvider);
  if (favoriteIds.isEmpty) return [];

  final repository = ref.watch(stopsRepositoryProvider);

  final favoritesFutures = favoriteIds.map((id) => repository.getStopById(id));
  final results = await Future.wait(favoritesFutures);

  return results.whereType<StopModel>().toList();
}
