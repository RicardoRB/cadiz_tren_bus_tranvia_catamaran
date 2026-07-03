import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../../../shared/models/enums.dart';
import '../../../stops/presentation/providers/stops_provider.dart';
import '../providers/user_location_provider.dart';
import '../widgets/stop_preview_sheet.dart';
import '../widgets/transport_mode_filter.dart';

class MapScreen extends ConsumerStatefulWidget {
  final String? focusStopId;

  const MapScreen({super.key, this.focusStopId});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  Set<TransportMode> _selectedModes = Set.from(TransportMode.values);
  bool _isInitialFocusDone = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _showStopPreview(StopModel stop) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StopPreviewSheet(stop: stop),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stopsAsync = ref.watch(allStopsProvider);
    final locationState = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Paradas')),
      body: stopsAsync.when(
        data: (allStops) {
          final filteredStops = allStops
              .where((s) => _selectedModes.contains(s.transportMode))
              .toList();

          if (!_isInitialFocusDone && widget.focusStopId != null) {
            final focusStop = allStops
                .where((s) => s.id == widget.focusStopId)
                .firstOrNull;
            if (focusStop != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _mapController.move(LatLng(focusStop.lat, focusStop.lon), 16);
                setState(() {
                  _isInitialFocusDone = true;
                });
              });
            }
          }

          return FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(36.5297, -6.2946), // Cádiz city
              initialZoom: 12,
              maxZoom: 18,
              minZoom: 8,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.cadiztransit.app',
              ),
              MarkerClusterLayerWidget(
                options: MarkerClusterLayerOptions(
                  maxClusterRadius: 45,
                  size: const Size(40, 40),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(50),
                  markers: filteredStops.map((stop) {
                    return Marker(
                      point: LatLng(stop.lat, stop.lon),
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => _showStopPreview(stop),
                        child: Icon(
                          TransportModeColors.getModeIcon(stop.transportMode),
                          color: TransportModeColors.getModeColor(
                            stop.transportMode,
                          ),
                          size: 30,
                        ),
                      ),
                    );
                  }).toList(),
                  builder: (context, markers) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Center(
                        child: Text(
                          markers.length.toString(),
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (locationState.status == LocationStatus.granted &&
                  locationState.position != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        locationState.position!.latitude,
                        locationState.position!.longitude,
                      ),
                      width: 20,
                      height: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'filter_fab',
            onPressed: null, // PopupMenuButton handles interaction
            child: TransportModeFilter(
              selectedModes: _selectedModes,
              onChanged: (newSelection) {
                setState(() {
                  _selectedModes = newSelection;
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'location_fab',
            onPressed: () {
              if (locationState.status == LocationStatus.denied ||
                  locationState.status == LocationStatus.permanentlyDenied) {
                _showLocationDeniedDialog();
              } else {
                ref
                    .read(userLocationProvider.notifier)
                    .updateLocation(requestPermission: true)
                    .then((_) {
                      final newState = ref.read(userLocationProvider);
                      if (newState.status == LocationStatus.granted &&
                          newState.position != null) {
                        _mapController.move(
                          LatLng(
                            newState.position!.latitude,
                            newState.position!.longitude,
                          ),
                          15,
                        );
                      }
                    });
              }
            },
            child: Icon(
              locationState.status == LocationStatus.granted
                  ? Icons.my_location
                  : Icons.location_searching,
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permiso de ubicación'),
        content: const Text(
          'Para mostrar tu ubicación en el mapa y encontrar paradas cercanas, necesitamos permiso de acceso a la ubicación.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCELAR'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(userLocationProvider.notifier).openSettings();
            },
            child: const Text('AJUSTES'),
          ),
        ],
      ),
    );
  }
}
