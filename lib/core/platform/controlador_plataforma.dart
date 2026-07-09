import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'tipo_plataforma.dart';

part 'controlador_plataforma.g.dart';

@riverpod
class ControladorPlataforma extends _$ControladorPlataforma {
  @override
  TipoPlataforma build() {
    if (kIsWeb) return TipoPlataforma.web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return TipoPlataforma.android;
      case TargetPlatform.iOS:
        return TipoPlataforma.ios;
      case TargetPlatform.windows:
        return TipoPlataforma.windows;
      case TargetPlatform.macOS:
        return TipoPlataforma.macos;
      case TargetPlatform.linux:
        return TipoPlataforma.linux;
      default:
        return TipoPlataforma.android;
    }
  }

  void setPlataforma(TipoPlataforma plataforma) {
    state = plataforma;
  }
}
