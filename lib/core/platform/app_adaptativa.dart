import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';
import 'controlador_plataforma.dart';
import 'tipo_plataforma.dart';
import '../theme/platform_themes.dart';

class AppAdaptativa extends ConsumerWidget {
  final GoRouter routerConfig;
  final String Function(BuildContext) onGenerateTitle;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final List<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final List<Locale> supportedLocales;

  const AppAdaptativa.router({
    super.key,
    required this.routerConfig,
    required this.onGenerateTitle,
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
    required this.localizationsDelegates,
    required this.supportedLocales,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plataforma = ref.watch(controladorPlataformaProvider);

    switch (plataforma) {
      case TipoPlataforma.windows:
        return FluentApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
          title: onGenerateTitle(context),
          themeMode: themeMode,
          theme: PlatformThemes.fluentLightTheme(theme),
          darkTheme: PlatformThemes.fluentDarkTheme(darkTheme),
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
        );
      case TipoPlataforma.macos:
        return MacosApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
          title: onGenerateTitle(context),
          themeMode: themeMode,
          theme: PlatformThemes.macosLightTheme(theme),
          darkTheme: PlatformThemes.macosDarkTheme(darkTheme),
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
        );
      case TipoPlataforma.ios:
        return CupertinoApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
          onGenerateTitle: onGenerateTitle,
          theme: PlatformThemes.cupertinoTheme(
            themeMode == ThemeMode.dark ? darkTheme : theme,
          ),
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
        );
      case TipoPlataforma.linux:
      case TipoPlataforma.android:
      case TipoPlataforma.web:
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
          onGenerateTitle: onGenerateTitle,
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
        );
    }
  }
}
