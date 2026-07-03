// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Favorites)
final favoritesProvider = FavoritesProvider._();

final class FavoritesProvider
    extends $NotifierProvider<Favorites, Set<String>> {
  FavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesHash();

  @$internal
  @override
  Favorites create() => Favorites();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$favoritesHash() => r'9be6acf8d630749ada1b6175f37838eef3872296';

abstract class _$Favorites extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(favoriteStops)
final favoriteStopsProvider = FavoriteStopsProvider._();

final class FavoriteStopsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StopModel>>,
          List<StopModel>,
          FutureOr<List<StopModel>>
        >
    with $FutureModifier<List<StopModel>>, $FutureProvider<List<StopModel>> {
  FavoriteStopsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteStopsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteStopsHash();

  @$internal
  @override
  $FutureProviderElement<List<StopModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StopModel>> create(Ref ref) {
    return favoriteStops(ref);
  }
}

String _$favoriteStopsHash() => r'568901b19f1eff9cdde4c99c603bc67a09d8c2ac';
