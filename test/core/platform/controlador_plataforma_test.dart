import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/core/platform/controlador_plataforma.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/core/platform/tipo_plataforma.dart';

void main() {
  test('ControladorPlataforma sets and gets plataforma', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(controladorPlataformaProvider.notifier);

    expect(
      container.read(controladorPlataformaProvider),
      isA<TipoPlataforma>(),
    );

    controller.setPlataforma(TipoPlataforma.windows);
    expect(
      container.read(controladorPlataformaProvider),
      TipoPlataforma.windows,
    );

    controller.setPlataforma(TipoPlataforma.ios);
    expect(container.read(controladorPlataformaProvider), TipoPlataforma.ios);
  });
}
