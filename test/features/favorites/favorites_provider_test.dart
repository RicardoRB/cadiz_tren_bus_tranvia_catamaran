import 'package:flutter_test/flutter_test.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/core/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('FavoriteStops initial state is empty when no prefs', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );

    expect(container.read(favoriteStopsProvider), isEmpty);
  });

  test('FavoriteStops toggles and saves to prefs', () async {
    SharedPreferences.setMockInitialValues({
      'favorite_stops': ['stop1']
    });
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );

    final notifier = container.read(favoriteStopsProvider.notifier);

    expect(container.read(favoriteStopsProvider), contains('stop1'));

    await notifier.toggleFavorite('stop1');
    expect(container.read(favoriteStopsProvider), isEmpty);
    expect(prefs.getStringList('favorite_stops'), isEmpty);

    await notifier.toggleFavorite('stop2');
    expect(container.read(favoriteStopsProvider), contains('stop2'));
    expect(prefs.getStringList('favorite_stops'), contains('stop2'));
  });

  test('FavoriteLines initial state', () async {
    SharedPreferences.setMockInitialValues({
      'favorite_lines': ['line1']
    });
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );

    expect(container.read(favoriteLinesProvider), contains('line1'));
  });
}
