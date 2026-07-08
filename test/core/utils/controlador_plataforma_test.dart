import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/core/utils/controlador_plataforma.dart';

void main() {
  test('ControladorPlataforma should detect platform correctly', () {
    final container = ProviderContainer();
    final controlador = container.read(controladorPlataformaProvider.notifier);
    final plataforma = container.read(controladorPlataformaProvider);

    // defaultTargetPlatform in tests is usually android
    expect(plataforma, TipoPlataforma.android);
  });

  test('ControladorPlataforma should allow overrides', () {
    final container = ProviderContainer();
    final notifier = container.read(controladorPlataformaProvider.notifier);

    notifier.setPlataforma(TipoPlataforma.ios);
    var plataforma = container.read(controladorPlataformaProvider);
    expect(plataforma, TipoPlataforma.ios);
    expect(plataforma.isApple, true);
    expect(plataforma.isMaterial, false);

    notifier.setPlataforma(TipoPlataforma.windows);
    plataforma = container.read(controladorPlataformaProvider);
    expect(plataforma, TipoPlataforma.windows);
    expect(plataforma.isWindows, true);
    expect(plataforma.isApple, false);
  });
}
