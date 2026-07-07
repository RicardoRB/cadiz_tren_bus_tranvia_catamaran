import 'dart:io';
import 'package:drift/native.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';
import 'package:logging/logging.dart';
import 'generators/factory.dart';

final _logger = Logger('GenerateDatabase');

void main() async {
  // Setup logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final outputPath = 'assets/data/cadiz_transit.sqlite';
  final file = File(outputPath);

  if (file.existsSync()) {
    _logger.info('Deleting existing database at $outputPath...');
    file.deleteSync();
  } else {
    // Ensure the directory exists
    file.parent.createSync(recursive: true);
  }

  _logger.info('Creating new database at $outputPath...');

  // Create a connection to the file
  final db = AppDatabase(NativeDatabase(file));

  try {
    // Force schema creation
    await db.customSelect('SELECT 1').get();

    _logger.info('Populating bus data...');
    TransportDataFactory transportDataFactory = TransportDataFactory(db);

    for (TransportMode mode in TransportMode.values) {
      if (transportDataFactory.contains(mode)) {
        final busGenerator = transportDataFactory.get(mode);
        await busGenerator.populate();
      }
    }

    _logger.info('Database generation complete!');
  } catch (e, stack) {
    _logger.severe('Error generating database: $e', e, stack);
    rethrow;
  } finally {
    await db.close();
  }
}
