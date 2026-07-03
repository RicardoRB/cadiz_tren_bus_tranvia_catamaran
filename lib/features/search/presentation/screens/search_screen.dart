import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../providers/search_provider.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(searchResultsProvider);
    final query = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Buscar paradas o líneas...',
            border: InputBorder.none,
          ),
          onChanged: (value) =>
              ref.read(searchQueryProvider.notifier).update(value),
        ),
      ),
      body: resultsAsync.when(
        data: (results) {
          if (query.isEmpty) {
            return const Center(child: Text('Empieza a escribir para buscar'));
          }
          if (query.length < 2) {
            return const Center(child: Text('Escribe al menos 2 caracteres'));
          }
          if (results.routes.isEmpty && results.stops.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('No se han encontrado resultados para "$query"'),
                ],
              ),
            );
          }

          return ListView(
            children: [
              if (results.routes.isNotEmpty) ...[
                const _SectionHeader(title: 'Líneas'),
                ...results.routes.map(
                  (route) => ListTile(
                    leading: Icon(
                      TransportModeColors.getModeIcon(route.transportMode),
                      color: TransportModeColors.getModeColor(
                        route.transportMode,
                      ),
                    ),
                    title: Text(route.name),
                    subtitle: Text(
                      TransportModeColors.getModeName(route.transportMode),
                    ),
                    onTap: () => context.push('/lines/detail/${route.id}'),
                  ),
                ),
              ],
              if (results.stops.isNotEmpty) ...[
                const _SectionHeader(title: 'Paradas'),
                ...results.stops.map(
                  (stop) => ListTile(
                    leading: Icon(
                      TransportModeColors.getModeIcon(stop.transportMode),
                      color: TransportModeColors.getModeColor(
                        stop.transportMode,
                      ),
                    ),
                    title: Text(stop.name),
                    subtitle: Text(
                      TransportModeColors.getModeName(stop.transportMode),
                    ),
                    onTap: () => context.push('/stops/${stop.id}'),
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
