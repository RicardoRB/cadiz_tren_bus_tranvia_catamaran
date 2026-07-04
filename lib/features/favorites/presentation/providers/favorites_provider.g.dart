// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoriteStops)
final favoriteStopsProvider = FavoriteStopsProvider._();

final class FavoriteStopsProvider
    extends $NotifierProvider<FavoriteStops, Set<String>> {
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
  FavoriteStops create() => FavoriteStops();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$favoriteStopsHash() => r'c7498ac3806277df7ec1e51a3fde5ba16d1436c9';

abstract class _$FavoriteStops extends $Notifier<Set<String>> {
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

@ProviderFor(favoriteStopsList)
final favoriteStopsListProvider = FavoriteStopsListProvider._();

final class FavoriteStopsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StopModel>>,
          List<StopModel>,
          FutureOr<List<StopModel>>
        >
    with $FutureModifier<List<StopModel>>, $FutureProvider<List<StopModel>> {
  FavoriteStopsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteStopsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteStopsListHash();

  @$internal
  @override
  $FutureProviderElement<List<StopModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StopModel>> create(Ref ref) {
    return favoriteStopsList(ref);
  }
}

String _$favoriteStopsListHash() => r'f512247de082938155e460cb7ca1eb86eb50450f';

@ProviderFor(FavoriteLines)
final favoriteLinesProvider = FavoriteLinesProvider._();

final class FavoriteLinesProvider
    extends $NotifierProvider<FavoriteLines, Set<String>> {
  FavoriteLinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteLinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteLinesHash();

  @$internal
  @override
  FavoriteLines create() => FavoriteLines();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$favoriteLinesHash() => r'54ac7269b230281694e65c115f8fb9ba3dffc79e';

abstract class _$FavoriteLines extends $Notifier<Set<String>> {
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

@ProviderFor(favoriteLinesList)
final favoriteLinesListProvider = FavoriteLinesListProvider._();

final class FavoriteLinesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RouteModel>>,
          List<RouteModel>,
          FutureOr<List<RouteModel>>
        >
    with $FutureModifier<List<RouteModel>>, $FutureProvider<List<RouteModel>> {
  FavoriteLinesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteLinesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteLinesListHash();

  @$internal
  @override
  $FutureProviderElement<List<RouteModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RouteModel>> create(Ref ref) {
    return favoriteLinesList(ref);
  }
}

String _$favoriteLinesListHash() => r'14767b95b7c0a39fe697da0cd24eea7748b63994';
