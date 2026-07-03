import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/theme/theme_provider.dart';

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
