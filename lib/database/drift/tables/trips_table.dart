import 'package:drift/drift.dart';
import 'routes_table.dart';
import '../../../shared/models/enums.dart';

@DataClassName('Trip')
class Trips extends Table {
  TextColumn get id => text()();
  TextColumn get routeId => text().references(Routes, #id)();
  TextColumn get direction => text().map(const DirectionConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

class DirectionConverter extends TypeConverter<Direction, String> {
  const DirectionConverter();
  @override
  Direction fromSql(String fromDb) => Direction.fromJson(fromDb);
  @override
  String toSql(Direction value) => value.toDb();
}
