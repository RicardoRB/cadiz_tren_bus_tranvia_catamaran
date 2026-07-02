import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/theme_provider.dart';
import '../providers/counter_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text(
              'Tema',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Sistema'),
            value: ThemeMode.system,
            groupValue: themeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeControllerProvider.notifier).setThemeMode(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Claro'),
            value: ThemeMode.light,
            groupValue: themeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeControllerProvider.notifier).setThemeMode(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Oscuro'),
            value: ThemeMode.dark,
            groupValue: themeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeControllerProvider.notifier).setThemeMode(value);
              }
            },
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'Otros',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('Valor del contador (desde Settings):'),
            subtitle: Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Volver'),
            ),
          ),
        ],
      ),
    );
  }
}
