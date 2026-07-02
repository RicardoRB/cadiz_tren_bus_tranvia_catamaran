import 'package:drift/drift.dart';
import 'stops_table.dart';
import 'trips_table.dart';
import '../../../shared/models/enums.dart';

@DataClassName('StopTime')
class StopTimes extends Table {
  TextColumn get tripId => text().references(Trips, #id)();
  TextColumn get stopId => text().references(Stops, #id)();
  IntColumn get sequence => integer()();
  TextColumn get arrivalTime => text()();
  TextColumn get departureTime => text()();
  TextColumn get dayType => text().map(const DayTypeConverter())();

  @override
  Set<Column> get primaryKey => {tripId, stopId, sequence};
}

class DayTypeConverter extends TypeConverter<DayType, String> {
  const DayTypeConverter();
  @override
  DayType fromSql(String fromDb) => DayType.fromJson(fromDb);
  @override
  String toSql(DayType value) => value.toDb();
}
