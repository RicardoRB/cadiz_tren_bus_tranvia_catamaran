import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:logging/logging.dart';

abstract class TransportDataGenerator {
  final AppDatabase db;
  final Logger logger = Logger('TransportDataGenerator');

  TransportDataGenerator(this.db);

  Future<void> populate();
}
