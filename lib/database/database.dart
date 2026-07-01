import 'package:drift/drift.dart';

import 'connection/connection.dart' if (dart.library.html) 'connection/web.dart' if (dart.library.io) 'connection/native.dart' as impl;

part 'database.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

@DriftDatabase(tables: [Items])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;
}
