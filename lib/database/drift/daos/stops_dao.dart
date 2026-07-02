import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/stops_table.dart';
import '../../../shared/models/enums.dart';

part 'stops_dao.g.dart';

@DriftAccessor(tables: [Stops])
class StopsDao extends DatabaseAccessor<AppDatabase> with _$StopsDaoMixin {
  StopsDao(AppDatabase db) : super(db);

  Future<List<Stop>> getAllStops() => select(stops).get();
  Future<List<Stop>> getStopsByMode(TransportMode mode) => (select(stops)..where((t) => t.transportMode.equalsValue(mode))).get();
  Future<int> insertStop(Stop stop) => into(stops).insert(stop, mode: InsertMode.insertOrReplace);
}
