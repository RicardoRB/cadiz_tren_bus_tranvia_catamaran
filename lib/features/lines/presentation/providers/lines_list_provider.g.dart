// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lines_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(routesByMode)
final routesByModeProvider = RoutesByModeFamily._();

final class RoutesByModeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RouteModel>>,
          List<RouteModel>,
          FutureOr<List<RouteModel>>
        >
    with $FutureModifier<List<RouteModel>>, $FutureProvider<List<RouteModel>> {
  RoutesByModeProvider._({
    required RoutesByModeFamily super.from,
    required TransportMode super.argument,
  }) : super(
         retry: null,
         name: r'routesByModeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$routesByModeHash();

  @override
  String toString() {
    return r'routesByModeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<RouteModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RouteModel>> create(Ref ref) {
    final argument = this.argument as TransportMode;
    return routesByMode(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RoutesByModeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$routesByModeHash() => r'0f557cdf0ab64f45153ca83ab9cb06115b6cd9f7';

final class RoutesByModeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<RouteModel>>, TransportMode> {
  RoutesByModeFamily._()
    : super(
        retry: null,
        name: r'routesByModeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoutesByModeProvider call(TransportMode mode) =>
      RoutesByModeProvider._(argument: mode, from: this);

  @override
  String toString() => r'routesByModeProvider';
}

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

String _$filteredRoutesHash() => r'227ac6c53801fd333a2a47401f7521eb0aeac894';

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

String _$modeOperatorsHash() => r'8e9f1a177aa25e9886ff6a2dec0203a7b4b64769';

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

@ProviderFor(operatorsMap)
final operatorsMapProvider = OperatorsMapProvider._();

final class OperatorsMapProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, String>>,
          Map<String, String>,
          FutureOr<Map<String, String>>
        >
    with
        $FutureModifier<Map<String, String>>,
        $FutureProvider<Map<String, String>> {
  OperatorsMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorsMapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorsMapHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, String>> create(Ref ref) {
    return operatorsMap(ref);
  }
}

String _$operatorsMapHash() => r'7a0e91fc8d42787775551716cebd46cf5e6d8dc8';
