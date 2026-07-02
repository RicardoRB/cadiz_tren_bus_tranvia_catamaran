import 'package:drift/drift.dart';
import '../../../shared/models/enums.dart';

@DataClassName('Operator')
class Operators extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get transportMode => text().map(const TransportModeConverter())();
  TextColumn get attributionText => text().nullable()();
  TextColumn get licenseUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class TransportModeConverter extends TypeConverter<TransportMode, String> {
  const TransportModeConverter();
  @override
  TransportMode fromSql(String fromDb) => TransportMode.fromJson(fromDb);
  @override
  String toSql(TransportMode value) => value.toDb();
}
