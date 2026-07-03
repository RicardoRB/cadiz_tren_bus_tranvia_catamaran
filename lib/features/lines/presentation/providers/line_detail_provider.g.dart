// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routeDetail)
final routeDetailProvider = RouteDetailFamily._();

final class RouteDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<RouteModel?>,
          RouteModel?,
          FutureOr<RouteModel?>
        >
    with $FutureModifier<RouteModel?>, $FutureProvider<RouteModel?> {
  RouteDetailProvider._({
    required RouteDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'routeDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routeDetailHash();

  @override
  String toString() {
    return r'routeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RouteModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RouteModel?> create(Ref ref) {
    final argument = this.argument as String;
    return routeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RouteDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routeDetailHash() => r'17f372131d72194a78eddfccedd68658acb97886';

final class RouteDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RouteModel?>, String> {
  RouteDetailFamily._()
    : super(
        retry: null,
        name: r'routeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RouteDetailProvider call(String id) =>
      RouteDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'routeDetailProvider';
}

@ProviderFor(routeStops)
final routeStopsProvider = RouteStopsFamily._();

final class RouteStopsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StopModel>>,
          List<StopModel>,
          FutureOr<List<StopModel>>
        >
    with $FutureModifier<List<StopModel>>, $FutureProvider<List<StopModel>> {
  RouteStopsProvider._({
    required RouteStopsFamily super.from,
    required (String, Direction) super.argument,
  }) : super(
         retry: null,
         name: r'routeStopsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routeStopsHash();

  @override
  String toString() {
    return r'routeStopsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<StopModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StopModel>> create(Ref ref) {
    final argument = this.argument as (String, Direction);
    return routeStops(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is RouteStopsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routeStopsHash() => r'5c50209ec8af811990577838872c9caf3a86817d';

final class RouteStopsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<StopModel>>,
          (String, Direction)
        > {
  RouteStopsFamily._()
    : super(
        retry: null,
        name: r'routeStopsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RouteStopsProvider call(String id, Direction direction) =>
      RouteStopsProvider._(argument: (id, direction), from: this);

  @override
  String toString() => r'routeStopsProvider';
}
