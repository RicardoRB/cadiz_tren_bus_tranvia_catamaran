import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../../../../shared/models/enums.dart';
import '../../../stops/presentation/providers/favorites_provider.dart';
import '../../../../shared/widgets/loading_shimmer.dart';
import '../../../map/presentation/providers/nearby_stops_provider.dart';
import '../../../map/presentation/providers/user_location_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Try to get location on start if permission already granted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userLocationProvider.notifier).updateLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesAsync = ref.watch(favoriteStopsProvider);
    final nearbyStopsAsync = ref.watch(nearbyStopsProvider);
    final locationState = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CadizTransit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
            tooltip: 'Buscar',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: 'Ajustes',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modos de Transporte',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _TransportModeCard(mode: TransportMode.bus),
                _TransportModeCard(mode: TransportMode.tram),
                _TransportModeCard(mode: TransportMode.commuterRail),
                _TransportModeCard(mode: TransportMode.catamaran),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paradas cercanas',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (locationState.status == LocationStatus.initial ||
                    locationState.status == LocationStatus.denied)
                  TextButton.icon(
                    onPressed: () => ref
                        .read(userLocationProvider.notifier)
                        .updateLocation(requestPermission: true),
                    icon: const Icon(Icons.location_on),
                    label: const Text('Activar'),
                  )
                else if (locationState.status == LocationStatus.permanentlyDenied ||
                    locationState.status == LocationStatus.disabled)
                  TextButton.icon(
                    onPressed: () =>
                        ref.read(userLocationProvider.notifier).openSettings(),
                    icon: const Icon(Icons.settings),
                    label: const Text('Ajustes'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            nearbyStopsAsync.when(
              data: (stops) {
                if (stops.isEmpty) {
                  if (locationState.status == LocationStatus.granted) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text('No hay paradas en 2km a la redonda'),
                        ),
                      ),
                    );
                  }
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'Activa la ubicación para ver paradas cercanas',
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stops.length > 3 ? 3 : stops.length,
                  itemBuilder: (context, index) {
                    final stop = stops[index];
                    return ListTile(
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
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/stops/${stop.id}'),
                    );
                  },
                );
              },
              loading: () =>
                  const LoadingShimmer(child: ListLoadingShimmer(itemCount: 3)),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            const SizedBox(height: 32),
            Text('Favoritos', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            favoritesAsync.when(
              data: (favorites) {
                if (favorites.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          'Aún no tienes favoritos',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final stop = favorites[index];
                    return ListTile(
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
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/stops/${stop.id}'),
                    );
                  },
                );
              },
              loading: () =>
                  const LoadingShimmer(child: ListLoadingShimmer(itemCount: 3)),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransportModeCard extends StatelessWidget {
  final TransportMode mode;

  const _TransportModeCard({required this.mode});

  @override
  Widget build(BuildContext context) {
    final color = TransportModeColors.getModeColor(mode);
    final icon = TransportModeColors.getModeIcon(mode);
    final name = TransportModeColors.getModeName(mode);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/lines/${mode.name}'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
