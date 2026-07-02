import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/trips_table.dart';

part 'trips_dao.g.dart';

@DriftAccessor(tables: [Trips])
class TripsDao extends DatabaseAccessor<AppDatabase> with _$TripsDaoMixin {
  TripsDao(super.db);

  Future<List<Trip>> getTripsByRoute(String routeId) => (select(trips)..where((t) => t.routeId.equals(routeId))).get();
  Future<int> insertTrip(Trip trip) => into(trips).insert(trip, mode: InsertMode.insertOrReplace);
}
