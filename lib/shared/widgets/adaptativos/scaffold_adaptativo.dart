import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';
import '../../../core/utils/controlador_plataforma.dart';

class DestinoNavegacion {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String tooltip;

  const DestinoNavegacion({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.tooltip = '',
  });
}

class ScaffoldAdaptativo extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  final List<DestinoNavegacion> destinos;

  const ScaffoldAdaptativo({
    super.key,
    required this.navigationShell,
    required this.destinos,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plataforma = ref.watch(controladorPlataformaProvider);

    switch (plataforma) {
      case TipoPlataforma.windows:
        return _buildWindowsScaffold(context);
      case TipoPlataforma.macos:
        return _buildMacosScaffold(context);
      case TipoPlataforma.ios:
        return _buildIosScaffold(context);
      default:
        return _buildMaterialScaffold(context);
    }
  }

  Widget _buildMaterialScaffold(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index),
        destinations: destinos
            .map((d) => NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: d.label,
                  tooltip: d.tooltip,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildIosScaffold(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        items: destinos
            .map((d) => BottomNavigationBarItem(
                  icon: Icon(d.icon),
                  activeIcon: Icon(d.selectedIcon),
                  label: d.label,
                ))
            .toList(),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => navigationShell,
        );
      },
    );
  }

  Widget _buildWindowsScaffold(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: navigationShell.currentIndex,
        onChanged: (index) => navigationShell.goBranch(index),
        displayMode: PaneDisplayMode.auto,
        items: destinos
            .map((d) => PaneItem(
                  icon: Icon(d.icon),
                  title: Text(d.label),
                  body: navigationShell,
                ))
            .toList()
            .cast<NavigationPaneItem>(),
      ),
    );
  }

  Widget _buildMacosScaffold(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        builder: (context, scrollController) {
          return SidebarItems(
            currentIndex: navigationShell.currentIndex,
            onChanged: (index) => navigationShell.goBranch(index),
            items: destinos
                .map((d) => SidebarItem(
                      leading: MacosIcon(d.icon),
                      label: Text(d.label),
                    ))
                .toList(),
          );
        },
      ),
      child: navigationShell,
    );
  }
}
