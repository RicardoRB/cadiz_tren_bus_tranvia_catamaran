import '../enums.dart';

class StopModel {
  final String id;
  final String name;
  final double lat;
  final double lon;
  final TransportMode transportMode;
  final String operatorId;

  StopModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.transportMode,
    required this.operatorId,
  });
}
