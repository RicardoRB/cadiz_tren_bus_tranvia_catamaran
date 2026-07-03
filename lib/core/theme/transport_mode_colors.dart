import 'package:flutter/material.dart';
import '../../shared/models/enums.dart';

class TransportModeColors {
  static Color getModeColor(TransportMode mode) {
    switch (mode) {
      case TransportMode.bus:
        return Colors.blue;
      case TransportMode.tram:
        return Colors.orange;
      case TransportMode.commuterRail:
        return Colors.red;
      case TransportMode.catamaran:
        return Colors.cyan;
    }
  }

  static IconData getModeIcon(TransportMode mode) {
    switch (mode) {
      case TransportMode.bus:
        return Icons.directions_bus;
      case TransportMode.tram:
        return Icons.tram;
      case TransportMode.commuterRail:
        return Icons.directions_railway;
      case TransportMode.catamaran:
        return Icons.directions_boat;
    }
  }

  static String getModeName(TransportMode mode) {
    switch (mode) {
      case TransportMode.bus:
        return 'Autobús';
      case TransportMode.tram:
        return 'Tranvía';
      case TransportMode.commuterRail:
        return 'Cercanías';
      case TransportMode.catamaran:
        return 'Catamarán';
    }
  }
}
