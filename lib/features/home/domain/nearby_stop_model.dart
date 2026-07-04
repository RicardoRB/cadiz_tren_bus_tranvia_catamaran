import '../../../shared/models/enums.dart';

class NearbyStopModel {
  final String id;
  final String name;
  final double lat;
  final double lon;
  final TransportMode transportMode;
  final String nextDeparture;
  final double distanceInKm;

  NearbyStopModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.transportMode,
    required this.nextDeparture,
    required this.distanceInKm,
  });
}
