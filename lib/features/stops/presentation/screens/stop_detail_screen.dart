import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../../../../core/platform/pagina_adaptativa.dart';
import '../providers/stop_detail_provider.dart';
import '../providers/favorites_provider.dart';
import '../../../schedule/presentation/providers/schedule_provider.dart';
import '../../../schedule/presentation/widgets/schedule_table.dart';
import '../../../../shared/widgets/loading_shimmer.dart';

class StopDetailScreen extends ConsumerStatefulWidget {
  final String stopId;

  const StopDetailScreen({super.key, required this.stopId});

  @override
  ConsumerState<StopDetailScreen> createState() => _StopDetailScreenState();
}

class _StopDetailScreenState extends ConsumerState<StopDetailScreen> {
  late DateTime _referenceTime;

  @override
  void initState() {
    super.initState();
    _referenceTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final stopAsync = ref.watch(stopDetailProvider(widget.stopId));
    final upcomingAsync = ref.watch(
      upcomingStopTimesProvider(widget.stopId, _referenceTime),
    );
    final isFavorite = ref.watch(favoritesProvider).contains(widget.stopId);
    final l10n = AppLocalizations.of(context)!;

    return PaginaAdaptativa(
      title: stopAsync.when(
        data: (stop) => Text(stop?.name ?? l10n.stopDetail),
        loading: () => Text(l10n.loading),
        error: (err, stack) => Text(l10n.error),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.map_outlined),
          onPressed: () => context.push('/stop-on-map?stopId=${widget.stopId}'),
          tooltip: l10n.viewOnMap,
        ),
        IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color: isFavorite ? Colors.red : null,
          onPressed: () {
            ref.read(favoritesProvider.notifier).toggleFavorite(widget.stopId);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isFavorite
                      ? l10n.removedFromFavorites
                      : l10n.addedToFavorites,
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ],
      body: stopAsync.when(
        data: (stop) {
          if (stop == null) {
            return Center(child: Text(l10n.stopNotFound));
          }

          final color = TransportModeColors.getModeColor(stop.transportMode);

          return Column(
            children: [
              ListTile(
                leading: Icon(
                  TransportModeColors.getModeIcon(stop.transportMode),
                  color: color,
                ),
                title: Text(stop.name),
                subtitle: Text(l10n.operatorId(stop.operatorId)),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      l10n.nextDepartures,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      l10n.today,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: upcomingAsync.when(
                  data: (times) {
                    if (times.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.noMoreServicesToday),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _showFullSchedule(context),
                            child: Text(l10n.viewFullSchedule),
                          ),
                        ],
                      );
                    }
                    return ListView.builder(
                      itemCount: times.length + 1,
                      itemBuilder: (context, index) {
                        if (index == times.length) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () => _showFullSchedule(context),
                              child: Text(l10n.viewFullSchedule),
                            ),
                          );
                        }
                        final time = times[index];
                        return ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text(time.arrivalTime.substring(0, 5)),
                          subtitle: Text(l10n.tripId(time.tripId)),
                        );
                      },
                    );
                  },
                  loading: () => const LoadingShimmer(
                    child: ListLoadingShimmer(itemCount: 5),
                  ),
                  error: (err, stack) =>
                      Center(child: Text(l10n.errorWithDetail(err.toString()))),
                ),
              ),
            ],
          );
        },
        loading: () => const LoadingShimmer(child: DetailLoadingShimmer()),
        error: (err, stack) =>
            Center(child: Text(l10n.errorWithDetail(err.toString()))),
      ),
    );
  }

  void _showFullSchedule(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(l10n.fullSchedule),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ScheduleTable(stopId: widget.stopId),
      ),
    );
  }
}
