// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controlador_plataforma.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControladorPlataforma)
final controladorPlataformaProvider = ControladorPlataformaProvider._();

final class ControladorPlataformaProvider
    extends $NotifierProvider<ControladorPlataforma, TipoPlataforma> {
  ControladorPlataformaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controladorPlataformaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$controladorPlataformaHash();

  @$internal
  @override
  ControladorPlataforma create() => ControladorPlataforma();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TipoPlataforma value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TipoPlataforma>(value),
    );
  }
}

String _$controladorPlataformaHash() =>
    r'432be212f6dceab05173e8f650f07c2f3244c223';

abstract class _$ControladorPlataforma extends $Notifier<TipoPlataforma> {
  TipoPlataforma build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TipoPlataforma, TipoPlataforma>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TipoPlataforma, TipoPlataforma>,
              TipoPlataforma,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
