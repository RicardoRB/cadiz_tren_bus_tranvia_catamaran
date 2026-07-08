import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/widgets/adaptativos/scaffold_adaptativo.dart';

class ShellScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return ScaffoldAdaptativo(
      navigationShell: navigationShell,
      destinos: const [
        DestinoNavegacion(
          icon: Icons.map_outlined,
          selectedIcon: Icons.map,
          label: 'Mapa',
          tooltip: 'Mapa de paradas',
        ),
        DestinoNavegacion(
          icon: Icons.list_alt_outlined,
          selectedIcon: Icons.list_alt,
          label: 'Cercanas',
          tooltip: 'Líneas cercanas',
        ),
      ],
    );
  }
}
