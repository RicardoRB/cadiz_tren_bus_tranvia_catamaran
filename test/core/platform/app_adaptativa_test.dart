import 'package:cadiz_tren_bus_tranvia_catamaran/core/platform/app_adaptativa.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/core/platform/controlador_plataforma.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/core/platform/tipo_plataforma.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/l10n/app_localizations.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/router/router.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macos_ui/macos_ui.dart';

void main() {
  testWidgets('AppAdaptativa shows FluentApp for Windows', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          controladorPlataformaProvider.overrideWith(() {
            final notifier = _MockControlador(TipoPlataforma.windows);
            return notifier;
          }),
        ],
        child: AppAdaptativa.router(
          routerConfig: router,
          onGenerateTitle: (context) => 'Test',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    expect(find.byType(FluentApp), findsOneWidget);
  });

  testWidgets('AppAdaptativa shows MacosApp for macOS', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          controladorPlataformaProvider.overrideWith(() {
            return _MockControlador(TipoPlataforma.macos);
          }),
        ],
        child: AppAdaptativa.router(
          routerConfig: router,
          onGenerateTitle: (context) => 'Test',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    expect(find.byType(MacosApp), findsOneWidget);
  });

  testWidgets('AppAdaptativa shows CupertinoApp for iOS', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          controladorPlataformaProvider.overrideWith(() {
            return _MockControlador(TipoPlataforma.ios);
          }),
        ],
        child: AppAdaptativa.router(
          routerConfig: router,
          onGenerateTitle: (context) => 'Test',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    expect(find.byType(CupertinoApp), findsOneWidget);
  });

  testWidgets('AppAdaptativa shows MaterialApp for Android', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          controladorPlataformaProvider.overrideWith(() {
            return _MockControlador(TipoPlataforma.android);
          }),
        ],
        child: AppAdaptativa.router(
          routerConfig: router,
          onGenerateTitle: (context) => 'Test',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

class _MockControlador extends ControladorPlataforma {
  final TipoPlataforma _plataforma;
  _MockControlador(this._plataforma);

  @override
  TipoPlataforma build() => _plataforma;
}
