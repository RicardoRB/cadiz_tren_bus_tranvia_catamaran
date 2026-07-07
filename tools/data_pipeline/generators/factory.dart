import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';
import 'base_generator.dart';
import 'bus_generator.dart';
import 'tram_generator.dart';

class TransportDataFactory {
  static Map<TransportMode, TransportDataGenerator> generators = {};

  TransportDataFactory(AppDatabase db) {
    generators = {
      TransportMode.bus: BusGenerator(db),
      TransportMode.tram: TramGenerator(db),
    };
  }

  bool contains(TransportMode mode) {
    return generators.containsKey(mode);
  }

  TransportDataGenerator get(final TransportMode mode) {
    if (!generators.containsKey(mode)) {
      throw UnimplementedError('Generator for $mode not implemented yet.');
    }
    TransportDataGenerator? transportDataGenerator = generators[mode];
    if (transportDataGenerator == null) {
      throw UnimplementedError('Generator for $mode not implemented yet.');
    }
    return transportDataGenerator;
  }
}
