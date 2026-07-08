import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/widgets/adaptativos/scaffold_adaptativo.dart';
import '../l10n/app_localizations.dart';

class ShellScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ScaffoldAdaptativo(
      navigationShell: navigationShell,
      destinos: [
        DestinoNavegacion(
          icon: Icons.map_outlined,
          selectedIcon: Icons.map,
          label: l10n.mapLabel,
          tooltip: l10n.mapTooltip,
        ),
        DestinoNavegacion(
          icon: Icons.list_alt_outlined,
          selectedIcon: Icons.list_alt,
          label: l10n.nearbyLabel,
          tooltip: l10n.nearbyTooltip,
        ),
      ],
    );
  }
}
