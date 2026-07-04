import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../providers/favorites_provider.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../../../shared/models/domain/route.dart';
import '../../../../shared/widgets/loading_shimmer.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteStopsAsync = ref.watch(favoriteStopsListProvider);
    final favoriteLinesAsync = ref.watch(favoriteLinesListProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favoritos'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.pin_drop), text: 'Paradas'),
              Tab(icon: Icon(Icons.directions_bus), text: 'Líneas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _FavoriteStopsList(asyncStops: favoriteStopsAsync),
            _FavoriteLinesList(asyncLines: favoriteLinesAsync),
          ],
        ),
      ),
    );
  }
}

class _FavoriteStopsList extends ConsumerWidget {
  final AsyncValue<List<StopModel>> asyncStops;

  const _FavoriteStopsList({required this.asyncStops});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return asyncStops.when(
      data: (stops) {
        if (stops.isEmpty) {
          return const Center(child: Text('No tienes paradas favoritas'));
        }
        return ListView.builder(
          itemCount: stops.length,
          itemBuilder: (context, index) {
            final stop = stops[index];
            return Dismissible(
              key: Key('stop_${stop.id}'),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                ref
                    .read(favoriteStopsProvider.notifier)
                    .toggleFavorite(stop.id);
              },
              child: ListTile(
                leading: Icon(
                  TransportModeColors.getModeIcon(stop.transportMode),
                  color: TransportModeColors.getModeColor(stop.transportMode),
                ),
                title: Text(stop.name),
                subtitle: Text(
                  TransportModeColors.getModeName(stop.transportMode),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/stops/${stop.id}'),
              ),
            );
          },
        );
      },
      loading: () => const LoadingShimmer(child: ListLoadingShimmer()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

class _FavoriteLinesList extends ConsumerWidget {
  final AsyncValue<List<RouteModel>> asyncLines;

  const _FavoriteLinesList({required this.asyncLines});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return asyncLines.when(
      data: (lines) {
        if (lines.isEmpty) {
          return const Center(child: Text('No tienes líneas favoritas'));
        }
        return ListView.builder(
          itemCount: lines.length,
          itemBuilder: (context, index) {
            final line = lines[index];
            return Dismissible(
              key: Key('line_${line.id}'),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                ref
                    .read(favoriteLinesProvider.notifier)
                    .toggleFavorite(line.id);
              },
              child: ListTile(
                leading: Icon(
                  TransportModeColors.getModeIcon(line.transportMode),
                  color: TransportModeColors.parseHex(
                    line.colorHex,
                    line.transportMode,
                  ),
                ),
                title: Text(line.name),
                subtitle: Text(
                  TransportModeColors.getModeName(line.transportMode),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/lines/${line.id}'),
              ),
            );
          },
        );
      },
      loading: () => const LoadingShimmer(child: ListLoadingShimmer()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
