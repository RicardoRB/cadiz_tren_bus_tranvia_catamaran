import '../../../shared/models/domain/stop.dart';
import '../../../shared/models/domain/route.dart';
import '../../../shared/models/enums.dart';

class NearbyLineEntry {
  final StopModel stop;
  final RouteModel route;
  final double distanciaMetros;
  final String? proximaSalida; // HH:mm format o null
  final Direction direction;

  NearbyLineEntry({
    required this.stop,
    required this.route,
    required this.distanciaMetros,
    this.proximaSalida,
    required this.direction,
  });

  String get distanciaFormateada {
    if (distanciaMetros < 1000) {
      return '${distanciaMetros.toStringAsFixed(0)} m';
    } else {
      final double km = distanciaMetros / 1000;
      return '${km.toStringAsFixed(1)} km';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NearbyLineEntry &&
          runtimeType == other.runtimeType &&
          stop.id == other.stop.id &&
          route.id == other.route.id &&
          direction == other.direction;

  @override
  int get hashCode => stop.id.hashCode ^ route.id.hashCode ^ direction.hashCode;
}
