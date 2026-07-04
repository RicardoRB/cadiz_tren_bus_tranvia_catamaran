// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_stops_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nearbyStops)
final nearbyStopsProvider = NearbyStopsProvider._();

final class NearbyStopsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StopModel>>,
          List<StopModel>,
          FutureOr<List<StopModel>>
        >
    with $FutureModifier<List<StopModel>>, $FutureProvider<List<StopModel>> {
  NearbyStopsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbyStopsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbyStopsHash();

  @$internal
  @override
  $FutureProviderElement<List<StopModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StopModel>> create(Ref ref) {
    return nearbyStops(ref);
  }
}

String _$nearbyStopsHash() => r'483635364f1f235cacf020371f3d665b359230e5';
