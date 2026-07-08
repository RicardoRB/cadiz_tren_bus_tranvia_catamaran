import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/models/enums.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/line_detail_provider.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../../../../core/platform/pagina_adaptativa.dart';
import '../../../../shared/widgets/loading_shimmer.dart';
import '../widgets/route_map_preview.dart';

class LineDetailScreen extends ConsumerStatefulWidget {
  final String routeId;

  const LineDetailScreen({super.key, required this.routeId});

  @override
  ConsumerState<LineDetailScreen> createState() => _LineDetailScreenState();
}

class _LineDetailScreenState extends ConsumerState<LineDetailScreen> {
  Direction _selectedDirection = Direction.outbound;

  @override
  Widget build(BuildContext context) {
    final routeAsync = ref.watch(routeDetailProvider(widget.routeId));
    final stopsAsync = ref.watch(
      routeStopsProvider(widget.routeId, _selectedDirection),
    );
    final l10n = AppLocalizations.of(context)!;

    return PaginaAdaptativa(
      title: routeAsync.when(
        data: (route) => Text(route?.name ?? l10n.lineDetail),
        loading: () => Text(l10n.loading),
        error: (err, stack) => Text(l10n.error),
      ),
      body: routeAsync.when(
        data: (route) {
          if (route == null) {
            return Center(child: Text(l10n.lineNotFound));
          }

          final color = TransportModeColors.parseHex(
            route.colorHex,
            route.transportMode,
          );

          return Column(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: stopsAsync.when(
                  data: (stops) => RouteMapPreview(
                    stops: stops,
                    routeColor: color,
                    transportMode: route.transportMode,
                  ),
                  loading: () => Container(
                    color: color.withValues(alpha: 0.1),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, stack) => Container(
                    color: color.withValues(alpha: 0.1),
                    child: const Center(child: Icon(Icons.error_outline)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SegmentedButton<Direction>(
                  segments: [
                    ButtonSegment(
                      value: Direction.outbound,
                      label: Text(l10n.outbound),
                      icon: const Icon(Icons.arrow_forward),
                    ),
                    ButtonSegment(
                      value: Direction.inbound,
                      label: Text(l10n.inbound),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                  selected: {_selectedDirection},
                  onSelectionChanged: (Set<Direction> newSelection) {
                    setState(() {
                      _selectedDirection = newSelection.first;
                    });
                  },
                ),
              ),
              Expanded(
                child: stopsAsync.when(
                  data: (stops) {
                    if (stops.isEmpty) {
                      return Center(child: Text(l10n.noStopsForDirection));
                    }
                    return ListView.builder(
                      itemCount: stops.length,
                      itemBuilder: (context, index) {
                        final stop = stops[index];
                        return ListTile(
                          leading: Column(
                            children: [
                              Container(
                                width: 2,
                                height: index == 0 ? 10 : 20,
                                color: index == 0 ? Colors.transparent : color,
                              ),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 2,
                                height: index == stops.length - 1 ? 10 : 20,
                                color: index == stops.length - 1
                                    ? Colors.transparent
                                    : color,
                              ),
                            ],
                          ),
                          title: Text(stop.name),
                          subtitle: Text(
                            TransportModeColors.getModeName(
                              context,
                              stop.transportMode,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push('/stops/${stop.id}'),
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
}
