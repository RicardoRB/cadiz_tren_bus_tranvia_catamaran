import 'package:fluent_ui/fluent_ui.dart' as fluent hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:yaru/yaru.dart';
import '../../../core/utils/controlador_plataforma.dart';
import '../../../core/theme/app_theme.dart';

class AppAdaptativa extends ConsumerWidget {
  final GoRouter routerConfig;
  final String title;

  const AppAdaptativa({
    super.key,
    required this.routerConfig,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plataforma = ref.watch(controladorPlataformaProvider);

    switch (plataforma) {
      case TipoPlataforma.windows:
        return fluent.FluentApp.router(
          title: title,
          routerConfig: routerConfig,
          debugShowCheckedModeBanner: false,
          theme: fluent.FluentThemeData(
            brightness: Brightness.light,
            accentColor: fluent.AccentColor.swatch(const {
              'normal': Colors.blue,
            }),
          ),
          darkTheme: fluent.FluentThemeData(
            brightness: Brightness.dark,
            accentColor: fluent.AccentColor.swatch(const {
              'normal': Colors.blue,
            }),
          ),
        );
      case TipoPlataforma.macos:
        return MacosApp.router(
          title: title,
          routerConfig: routerConfig,
          debugShowCheckedModeBanner: false,
          theme: MacosThemeData.light(),
          darkTheme: MacosThemeData.dark(),
        );
      case TipoPlataforma.ios:
        return CupertinoApp.router(
          title: title,
          routerConfig: routerConfig,
          debugShowCheckedModeBanner: false,
          theme: const CupertinoThemeData(),
        );
      case TipoPlataforma.linux:
        return YaruTheme(
          builder: (context, yaruTheme, child) {
            return MaterialApp.router(
              title: title,
              routerConfig: routerConfig,
              debugShowCheckedModeBanner: false,
              theme: yaruTheme.theme,
              darkTheme: yaruTheme.darkTheme,
            );
          },
        );
      case TipoPlataforma.android:
      case TipoPlataforma.web:
      default:
        return MaterialApp.router(
          title: title,
          routerConfig: routerConfig,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
    }
  }
}
