// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(stopDetail)
final stopDetailProvider = StopDetailFamily._();

final class StopDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<StopModel?>,
          StopModel?,
          FutureOr<StopModel?>
        >
    with $FutureModifier<StopModel?>, $FutureProvider<StopModel?> {
  StopDetailProvider._({
    required StopDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'stopDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopDetailHash();

  @override
  String toString() {
    return r'stopDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<StopModel?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<StopModel?> create(Ref ref) {
    final argument = this.argument as String;
    return stopDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StopDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopDetailHash() => r'8192b723ee72e47a7643d600b3b486c2cd3a34df';

final class StopDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<StopModel?>, String> {
  StopDetailFamily._()
    : super(
        retry: null,
        name: r'stopDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopDetailProvider call(String id) =>
      StopDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'stopDetailProvider';
}
