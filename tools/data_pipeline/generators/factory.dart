import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';
import 'base_generator.dart';
import 'bus_generator.dart';

class TransportDataFactory {
  static TransportDataGenerator create(TransportMode mode, AppDatabase db) {
    switch (mode) {
      case TransportMode.bus:
        return BusGenerator(db);
      default:
        throw UnimplementedError('Generator for $mode not implemented yet.');
    }
  }
}
