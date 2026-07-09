import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macos_ui/macos_ui.dart';
import 'controlador_plataforma.dart';
import 'tipo_plataforma.dart';
import '../../l10n/app_localizations.dart';

class ScaffoldAdaptativo extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldAdaptativo({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plataforma = ref.watch(controladorPlataformaProvider);
    final l10n = AppLocalizations.of(context)!;

    final destinations = [
      _NavigationItem(
        icon: Icons.map_outlined,
        selectedIcon: Icons.map,
        label: l10n.mapLabel,
        tooltip: l10n.mapTooltip,
      ),
      _NavigationItem(
        icon: Icons.list_alt_outlined,
        selectedIcon: Icons.list_alt,
        label: l10n.nearbyLabel,
        tooltip: l10n.nearbyTooltip,
      ),
    ];

    switch (plataforma) {
      case TipoPlataforma.windows:
        return NavigationView(
          pane: NavigationPane(
            selected: navigationShell.currentIndex,
            onChanged: (index) => navigationShell.goBranch(index),
            displayMode: PaneDisplayMode.auto,
            items: destinations
                .map(
                  (item) => PaneItem(
                    icon: Icon(item.icon),
                    title: Text(item.label),
                    body: const SizedBox.shrink(),
                  ),
                )
                .toList(),
          ),
          content: navigationShell,
        );

      case TipoPlataforma.macos:
        return MacosWindow(
          sidebar: Sidebar(
            minWidth: 200,
            builder: (context, scrollController) => SidebarItems(
              currentIndex: navigationShell.currentIndex,
              onChanged: (index) => navigationShell.goBranch(index),
              items: destinations
                  .map(
                    (item) => SidebarItem(
                      leading: MacosIcon(item.icon),
                      label: Text(item.label),
                    ),
                  )
                  .toList(),
            ),
          ),
          child: navigationShell,
        );

      case TipoPlataforma.ios:
        return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(index),
            items: destinations
                .map(
                  (item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    activeIcon: Icon(item.selectedIcon),
                    label: item.label,
                  ),
                )
                .toList(),
          ),
          tabBuilder: (context, index) => CupertinoTabView(
            builder: (context) => navigationShell,
          ),
        );

      case TipoPlataforma.linux:
      case TipoPlataforma.android:
      case TipoPlataforma.web:
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => navigationShell.goBranch(index),
            destinations: destinations
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: item.label,
                    tooltip: item.tooltip,
                  ),
                )
                .toList(),
          ),
        );
    }
  }
}

class _NavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String tooltip;

  _NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.tooltip,
  });
}
