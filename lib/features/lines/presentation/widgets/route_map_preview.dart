import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../../../shared/models/enums.dart';

class RouteMapPreview extends StatelessWidget {
  final List<StopModel> stops;
  final Color routeColor;
  final TransportMode transportMode;

  const RouteMapPreview({
    super.key,
    required this.stops,
    required this.routeColor,
    required this.transportMode,
  });

  @override
  Widget build(BuildContext context) {
    if (stops.isEmpty) {
      return const Center(child: Text('No hay paradas para mostrar'));
    }

    final points = stops.map((s) => LatLng(s.lat, s.lon)).toList();

    // Calculate bounds to fit all stops
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLon = points.first.longitude;
    double maxLon = points.first.longitude;

    for (var point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLon) minLon = point.longitude;
      if (point.longitude > maxLon) maxLon = point.longitude;
    }

    // Simple way to estimate zoom level or use fitBounds in MapOptions (though initialCenter is used there)
    // For simplicity, we use FlutterMap with an initial state and then we could use a controller
    // but here we want a static-ish preview that fits the bounds.

    return FlutterMap(
      options: MapOptions(
        initialCameraFit: CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(points),
          padding: const EdgeInsets.all(32),
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.cadiztransit.app',
        ),
        PolylineLayer(
          polylines: [
            Polyline(points: points, color: routeColor, strokeWidth: 4),
          ],
        ),
        MarkerLayer(
          markers: stops.map((stop) {
            return Marker(
              point: LatLng(stop.lat, stop.lon),
              width: 12,
              height: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: routeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
