import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../../../shared/widgets/location_permission_dialog.dart';
import '../../../../shared/widgets/loading_shimmer.dart';
import '../../../stops/presentation/providers/favorites_provider.dart';
import '../../domain/nearby_line_entry.dart';
import '../providers/nearby_lines_provider.dart';
import '../../../map/presentation/providers/user_location_provider.dart';

class NearbyLinesScreen extends ConsumerStatefulWidget {
  const NearbyLinesScreen({super.key});

  @override
  ConsumerState<NearbyLinesScreen> createState() => _NearbyLinesScreenState();
}

class _NearbyLinesScreenState extends ConsumerState<NearbyLinesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationState = ref.read(userLocationProvider);
      if (locationState.status == LocationStatus.initial) {
        _showPermissionDialog();
      }
    });
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LocationPermissionDialog(
        onConfirm: () => ref
            .read(userLocationProvider.notifier)
            .updateLocation(requestPermission: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(userLocationProvider);
    final nearbyLinesAsync = ref.watch(nearbyLinesProvider);
    final favoriteStopsAsync = ref.watch(favoriteStopsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.nearbyLabel),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(userLocationProvider.notifier).updateLocation();
          return ref.refresh(nearbyLinesProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            _FavoritesSection(favoriteStopsAsync: favoriteStopsAsync),
            _NearbyLinesSection(
              locationState: locationState,
              nearbyLinesAsync: nearbyLinesAsync,
              onActivateLocation: _showPermissionDialog,
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritesSection extends StatelessWidget {
  final AsyncValue<List<StopModel>> favoriteStopsAsync;

  const _FavoritesSection({required this.favoriteStopsAsync});

  @override
  Widget build(BuildContext context) {
    return favoriteStopsAsync.when(
      data: (stops) {
        if (stops.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context)!.favorites,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: stops.length,
                itemBuilder: (context, index) {
                  final stop = stops[index];
                  return _FavoriteCard(stop: stop);
                },
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final StopModel stop;

  const _FavoriteCard({required this.stop});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => context.push('/stops/${stop.id}'),
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    TransportModeColors.getModeIcon(stop.transportMode),
                    color: TransportModeColors.getModeColor(stop.transportMode),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      TransportModeColors.getModeName(context, stop.transportMode),
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                stop.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NearbyLinesSection extends ConsumerWidget {
  final UserLocationState locationState;
  final AsyncValue<List<NearbyLineEntry>> nearbyLinesAsync;
  final VoidCallback onActivateLocation;

  const _NearbyLinesSection({
    required this.locationState,
    required this.nearbyLinesAsync,
    required this.onActivateLocation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    if (locationState.status == LocationStatus.loading) {
      return const LoadingShimmer(child: ListLoadingShimmer());
    }

    if (locationState.status == LocationStatus.denied ||
        locationState.status == LocationStatus.permanentlyDenied ||
        locationState.status == LocationStatus.disabled) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.needLocationForNearby,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (locationState.status == LocationStatus.denied ||
                      locationState.status == LocationStatus.initial) {
                    onActivateLocation();
                  } else {
                    ref
                        .read(userLocationProvider.notifier)
                        .updateLocation(requestPermission: true);
                  }
                },
                child: Text(l10n.activateLocation),
              ),
            ],
          ),
        ),
      );
    }

    return nearbyLinesAsync.when(
      data: (entries) {
        if (entries.isEmpty && locationState.status == LocationStatus.granted) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(l10n.noNearbyLines),
            ),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: entries.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final entry = entries[index];
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: TransportModeColors.getModeColor(
                    entry.route.transportMode,
                  ).withAlpha(25), // 0.1 * 255 approx 25
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  TransportModeColors.getModeIcon(entry.route.transportMode),
                  color: TransportModeColors.getModeColor(
                    entry.route.transportMode,
                  ),
                ),
              ),
              title: Text(
                entry.route.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(entry.stop.name),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    entry.distanciaFormateada,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    entry.proximaSalida != null
                        ? l10n.nextDeparture(entry.proximaSalida!)
                        : l10n.noMoreServicesToday,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () => context.push('/stops/${entry.stop.id}'),
            );
          },
        );
      },
      loading: () => const LoadingShimmer(child: ListLoadingShimmer()),
      error: (err, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Text(l10n.errorWithDetail(err.toString())),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(nearbyLinesProvider),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
