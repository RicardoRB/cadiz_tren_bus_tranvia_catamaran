import 'package:drift/drift.dart';
import 'operators_table.dart';
import '../../../shared/models/enums.dart';

@DataClassName('Stop')
class Stops extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get lat => real()();
  RealColumn get lon => real()();
  TextColumn get transportMode => text().map(const TransportModeConverter())();
  TextColumn get operatorId => text().references(Operators, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
