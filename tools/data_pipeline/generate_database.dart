import 'dart:io';
import 'package:drift/native.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';
import 'generators/factory.dart';

void main() async {
  final outputPath = 'assets/data/cadiz_transit.sqlite';
  final file = File(outputPath);

  if (file.existsSync()) {
    print('Deleting existing database at $outputPath...');
    file.deleteSync();
  } else {
    // Ensure the directory exists
    file.parent.createSync(recursive: true);
  }

  print('Creating new database at $outputPath...');

  // Create a connection to the file
  // Using NativeDatabase with a raw File is fine for Dart VM
  final db = AppDatabase(NativeDatabase(file));

  try {
    // Force schema creation by running a dummy query or using the migrator
    // Drift usually does this on the first connection
    await db.customSelect('SELECT 1').get();

    // We only implement bus for now as requested
    print('Populating bus data...');
    final busGenerator = TransportDataFactory.create(TransportMode.bus, db);
    await busGenerator.populate();

    print('Database generation complete!');
  } catch (e, stack) {
    print('Error generating database: $e');
    print(stack);
    rethrow;
  } finally {
    await db.close();
  }
}
