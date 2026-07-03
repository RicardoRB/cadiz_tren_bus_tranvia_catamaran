// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lines_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(filteredRoutes)
final filteredRoutesProvider = FilteredRoutesFamily._();

final class FilteredRoutesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RouteModel>>,
          List<RouteModel>,
          FutureOr<List<RouteModel>>
        >
    with $FutureModifier<List<RouteModel>>, $FutureProvider<List<RouteModel>> {
  FilteredRoutesProvider._({
    required FilteredRoutesFamily super.from,
    required (TransportMode, {String? searchQuery, String? operatorId})
    super.argument,
  }) : super(
         retry: null,
         name: r'filteredRoutesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredRoutesHash();

  @override
  String toString() {
    return r'filteredRoutesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<RouteModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RouteModel>> create(Ref ref) {
    final argument =
        this.argument
            as (TransportMode, {String? searchQuery, String? operatorId});
    return filteredRoutes(
      ref,
      argument.$1,
      searchQuery: argument.searchQuery,
      operatorId: argument.operatorId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredRoutesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredRoutesHash() => r'bd366ae341ced40be20d3c40b84925bdd790e277';

final class FilteredRoutesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<RouteModel>>,
          (TransportMode, {String? searchQuery, String? operatorId})
        > {
  FilteredRoutesFamily._()
    : super(
        retry: null,
        name: r'filteredRoutesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredRoutesProvider call(
    TransportMode mode, {
    String? searchQuery,
    String? operatorId,
  }) => FilteredRoutesProvider._(
    argument: (mode, searchQuery: searchQuery, operatorId: operatorId),
    from: this,
  );

  @override
  String toString() => r'filteredRoutesProvider';
}

@ProviderFor(modeOperators)
final modeOperatorsProvider = ModeOperatorsFamily._();

final class ModeOperatorsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  ModeOperatorsProvider._({
    required ModeOperatorsFamily super.from,
    required TransportMode super.argument,
  }) : super(
         retry: null,
         name: r'modeOperatorsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$modeOperatorsHash();

  @override
  String toString() {
    return r'modeOperatorsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    final argument = this.argument as TransportMode;
    return modeOperators(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ModeOperatorsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$modeOperatorsHash() => r'9df4da8cd1e6085c19ec2796804c05da3d249827';

final class ModeOperatorsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<String>>, TransportMode> {
  ModeOperatorsFamily._()
    : super(
        retry: null,
        name: r'modeOperatorsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ModeOperatorsProvider call(TransportMode mode) =>
      ModeOperatorsProvider._(argument: mode, from: this);

  @override
  String toString() => r'modeOperatorsProvider';
}
