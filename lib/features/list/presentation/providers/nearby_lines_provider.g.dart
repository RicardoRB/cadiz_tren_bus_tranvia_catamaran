// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_lines_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nearbyLinesRepository)
final nearbyLinesRepositoryProvider = NearbyLinesRepositoryProvider._();

final class NearbyLinesRepositoryProvider
    extends
        $FunctionalProvider<
          NearbyLinesRepository,
          NearbyLinesRepository,
          NearbyLinesRepository
        >
    with $Provider<NearbyLinesRepository> {
  NearbyLinesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyLinesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyLinesRepositoryHash();

  @$internal
  @override
  $ProviderElement<NearbyLinesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NearbyLinesRepository create(Ref ref) {
    return nearbyLinesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NearbyLinesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NearbyLinesRepository>(value),
    );
  }
}

String _$nearbyLinesRepositoryHash() =>
    r'7a9a473faf9ab8be986c102da35e822fd86fd5b6';

@ProviderFor(nearbyLines)
final nearbyLinesProvider = NearbyLinesProvider._();

final class NearbyLinesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NearbyLineEntry>>,
          List<NearbyLineEntry>,
          FutureOr<List<NearbyLineEntry>>
        >
    with
        $FutureModifier<List<NearbyLineEntry>>,
        $FutureProvider<List<NearbyLineEntry>> {
  NearbyLinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyLinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyLinesHash();

  @$internal
  @override
  $FutureProviderElement<List<NearbyLineEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NearbyLineEntry>> create(Ref ref) {
    return nearbyLines(ref);
  }
}

String _$nearbyLinesHash() => r'fbb7bd0dd96d24293e4efd2b60ae66699be05495';
