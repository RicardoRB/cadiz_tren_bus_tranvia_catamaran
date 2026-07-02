import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseSeeder {
  static const String _dbName = 'cadiz_transit.sqlite';
  static const String _dbVersionKey = 'db_version';
  static const int _currentDbVersion = 1; // Incrementa esto para forzar re-copia

  Future<void> ensureDatabaseIsSeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final installedVersion = prefs.getInt(_dbVersionKey) ?? 0;

    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dbFolder.path, _dbName));

    if (!await dbFile.exists() || installedVersion < _currentDbVersion) {
      // Copiar desde assets
      final data = await rootBundle.load('assets/data/$_dbName');
      final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await dbFile.create(recursive: true);
      await dbFile.writeAsBytes(bytes);

      await prefs.setInt(_dbVersionKey, _currentDbVersion);
    }
  }

  Future<File> getDatabaseFile() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    return File(p.join(dbFolder.path, _dbName));
  }
}
