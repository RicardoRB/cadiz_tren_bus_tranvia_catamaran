import 'package:flutter/material.dart';
import '../../shared/models/enums.dart';
import '../../l10n/app_localizations.dart';

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

  static String getModeName(BuildContext context, TransportMode mode) {
    final l10n = AppLocalizations.of(context)!;
    switch (mode) {
      case TransportMode.bus:
        return l10n.bus;
      case TransportMode.tram:
        return l10n.tram;
      case TransportMode.commuterRail:
        return l10n.commuterRail;
      case TransportMode.catamaran:
        return l10n.catamaran;
    }
  }

  static Color parseHex(String? hex, TransportMode mode) {
    if (hex == null || hex.isEmpty) return getModeColor(mode);
    try {
      final buffer = StringBuffer();
      if (hex.length == 6 || hex.length == 7) buffer.write('ff');
      buffer.write(hex.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return getModeColor(mode);
    }
  }
}
