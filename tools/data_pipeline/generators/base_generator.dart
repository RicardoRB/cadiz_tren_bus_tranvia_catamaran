import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';

abstract class TransportDataGenerator {
  final AppDatabase db;

  TransportDataGenerator(this.db);

  Future<void> populate();
}
