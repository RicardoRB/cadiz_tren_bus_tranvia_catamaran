// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routesRepository)
final routesRepositoryProvider = RoutesRepositoryProvider._();

final class RoutesRepositoryProvider
    extends
        $FunctionalProvider<
          RoutesRepository,
          RoutesRepository,
          RoutesRepository
        >
    with $Provider<RoutesRepository> {
  RoutesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routesRepositoryHash();

  @$internal
  @override
  $ProviderElement<RoutesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RoutesRepository create(Ref ref) {
    return routesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoutesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoutesRepository>(value),
    );
  }
}

String _$routesRepositoryHash() => r'24e90327c0a6f11bca0a87ab4a7cfbbfad85e6da';

@ProviderFor(operatorsRepository)
final operatorsRepositoryProvider = OperatorsRepositoryProvider._();

final class OperatorsRepositoryProvider
    extends
        $FunctionalProvider<
          OperatorsRepository,
          OperatorsRepository,
          OperatorsRepository
        >
    with $Provider<OperatorsRepository> {
  OperatorsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorsRepositoryHash();

  @$internal
  @override
  $ProviderElement<OperatorsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OperatorsRepository create(Ref ref) {
    return operatorsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OperatorsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OperatorsRepository>(value),
    );
  }
}

String _$operatorsRepositoryHash() =>
    r'391ad78a8e3796d09229490ff8607e4f5f290168';
