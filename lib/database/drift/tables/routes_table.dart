import 'package:drift/drift.dart';
import 'operators_table.dart';

@DataClassName('Route')
class Routes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get operatorId => text().references(Operators, #id)();
  TextColumn get transportMode => text().map(const TransportModeConverter())();
  TextColumn get colorHex => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
