import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import '../seed/database_seeder.dart';

QueryExecutor connect() {
  return LazyDatabase(() async {
    final seeder = DatabaseSeeder();
    await seeder.ensureDatabaseIsSeeded();
    
    final file = await seeder.getDatabaseFile();

    final cachebase = await getTemporaryDirectory();
    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
