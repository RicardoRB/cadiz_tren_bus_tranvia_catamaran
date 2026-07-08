import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../shared/widgets/adaptativos/pagina_adaptativa.dart';
import '../../../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return PaginaAdaptativa(
      title: l10n.settingsTitle,
      child: ListView(
        children: [
          ListTile(
            title: Text(
              l10n.themeTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          RadioGroup<ThemeMode>(
            groupValue: themeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeControllerProvider.notifier).setThemeMode(value);
              }
            },
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: Text(l10n.systemTheme),
                  value: ThemeMode.system,
                ),
                RadioListTile<ThemeMode>(
                  title: Text(l10n.lightTheme),
                  value: ThemeMode.light,
                ),
                RadioListTile<ThemeMode>(
                  title: Text(l10n.darkTheme),
                  value: ThemeMode.dark,
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              l10n.othersTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
