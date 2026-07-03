import 'package:drift/drift.dart';
import '../../../database/drift/app_database.dart';
import '../../../shared/models/domain/route.dart';
import '../../../shared/models/domain/stop.dart';

class SearchRepository {
  final AppDatabase _db;

  SearchRepository(this._db);

  Future<List<RouteModel>> searchRoutes(String query) async {
    final results = await (_db.select(_db.routes)
          ..where((t) => t.name.like('%$query%')))
        .get();
    return results.map((r) => RouteModel(
      id: r.id,
      name: r.name,
      operatorId: r.operatorId,
      transportMode: r.transportMode,
      colorHex: r.colorHex,
    )).toList();
  }

  Future<List<StopModel>> searchStops(String query) async {
    final results = await (_db.select(_db.stops)
          ..where((t) => t.name.like('%$query%')))
        .get();
    return results.map((s) => StopModel(
      id: s.id,
      name: s.name,
      lat: s.lat,
      lon: s.lon,
      transportMode: s.transportMode,
      operatorId: s.operatorId,
    )).toList();
  }
}
