import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/transport_mode_colors.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: stopAsync.when(
          data: (stop) => Text(stop?.name ?? 'Detalle de parada'),
          loading: () => const Text('Cargando...'),
          error: (err, stack) => const Text('Error'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => context.push('/map?stopId=${widget.stopId}'),
            tooltip: 'Ver en mapa',
          ),
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? Colors.red : null,
            onPressed: () {
              ref
                  .read(favoritesProvider.notifier)
                  .toggleFavorite(widget.stopId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite
                        ? 'Eliminado de favoritos'
                        : 'Añadido a favoritos',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: stopAsync.when(
        data: (stop) {
          if (stop == null) {
            return const Center(child: Text('Parada no encontrada'));
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
                subtitle: Text('Operador ID: ${stop.operatorId}'),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      'Próximos pasos',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Hoy',
                      style: TextStyle(fontStyle: FontStyle.italic),
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
                          const Text('No hay más servicios para hoy'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _showFullSchedule(context),
                            child: const Text('Ver horario completo'),
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
                              child: const Text('Ver horario completo'),
                            ),
                          );
                        }
                        final time = times[index];
                        return ListTile(
                          leading: const Icon(Icons.access_time),
                          title: Text(time.arrivalTime.substring(0, 5)),
                          subtitle: Text('Trip ID: ${time.tripId}'),
                        );
                      },
                    );
                  },
                  loading: () => const LoadingShimmer(
                    child: ListLoadingShimmer(itemCount: 5),
                  ),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ),
            ],
          );
        },
        loading: () => const LoadingShimmer(child: DetailLoadingShimmer()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  void _showFullSchedule(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Horario completo'),
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
