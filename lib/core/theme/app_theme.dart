import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Clase que define los temas claro y oscuro de la aplicación
/// utilizando [FlexColorScheme].
class AppTheme {
  // Privamos el constructor para evitar instanciación
  AppTheme._();

  /// Tema para el modo claro
  static ThemeData get lightTheme => FlexThemeData.light(
        scheme: FlexScheme.blue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      );

  /// Tema para el modo oscuro
  static ThemeData get darkTheme => FlexThemeData.dark(
        scheme: FlexScheme.blue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      );
}
