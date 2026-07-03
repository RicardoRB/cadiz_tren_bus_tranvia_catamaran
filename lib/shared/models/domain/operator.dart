import '../enums.dart';

class OperatorModel {
  final String id;
  final String name;
  final TransportMode transportMode;
  final String? attributionText;
  final String? licenseUrl;

  OperatorModel({
    required this.id,
    required this.name,
    required this.transportMode,
    this.attributionText,
    this.licenseUrl,
  });
}
