import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/core/theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Tema', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          RadioGroup<ThemeMode>(
            groupValue: themeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeControllerProvider.notifier).setThemeMode(value);
              }
            },
            child: const Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: Text('Sistema'),
                  value: ThemeMode.system,
                ),
                RadioListTile<ThemeMode>(
                  title: Text('Claro'),
                  value: ThemeMode.light,
                ),
                RadioListTile<ThemeMode>(
                  title: Text('Oscuro'),
                  value: ThemeMode.dark,
                ),
              ],
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text('Otros', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
