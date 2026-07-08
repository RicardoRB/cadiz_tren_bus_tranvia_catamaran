import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../providers/search_provider.dart';
import '../../../../shared/widgets/loading_shimmer.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(searchResultsProvider);
    final query = ref.watch(searchQueryProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: l10n.searchHint,
            border: InputBorder.none,
          ),
          onChanged: (value) =>
              ref.read(searchQueryProvider.notifier).update(value),
        ),
      ),
      body: resultsAsync.when(
        data: (results) {
          if (query.isEmpty) {
            return Center(child: Text(l10n.startTypingToSearch));
          }
          if (query.length < 2) {
            return Center(child: Text(l10n.typeAtLeastTwoChars));
          }
          if (results.routes.isEmpty && results.stops.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(l10n.noResultsFor(query)),
                ],
              ),
            );
          }

          return ListView(
            children: [
              if (results.routes.isNotEmpty) ...[
                _SectionHeader(title: l10n.lines),
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
                      TransportModeColors.getModeName(
                        context,
                        route.transportMode,
                      ),
                    ),
                    onTap: () => context.push('/lines/${route.id}'),
                  ),
                ),
              ],
              if (results.stops.isNotEmpty) ...[
                _SectionHeader(title: l10n.stops),
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
                      TransportModeColors.getModeName(
                        context,
                        stop.transportMode,
                      ),
                    ),
                    onTap: () => context.push('/stops/${stop.id}'),
                  ),
                ),
              ],
            ],
          );
        },
        loading: () => const LoadingShimmer(child: ListLoadingShimmer()),
        error: (err, stack) =>
            Center(child: Text(l10n.errorWithDetail(err.toString()))),
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
