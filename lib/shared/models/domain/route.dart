import '../enums.dart';

class RouteModel {
  final String id;
  final String name;
  final String operatorId;
  final TransportMode transportMode;
  final String? colorHex;

  RouteModel({
    required this.id,
    required this.name,
    required this.operatorId,
    required this.transportMode,
    this.colorHex,
  });
}
