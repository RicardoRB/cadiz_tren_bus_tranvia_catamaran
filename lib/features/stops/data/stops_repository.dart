import '../../../database/drift/app_database.dart';
import '../../../database/drift/daos/stops_dao.dart';
import '../../../shared/models/domain/stop.dart';
import '../../../shared/models/enums.dart';

class StopsRepository {
  final StopsDao _stopsDao;

  StopsRepository(this._stopsDao);

  Future<List<StopModel>> getAllStops() async {
    final stops = await _stopsDao.getAllStops();
    return stops.map(_mapToDomain).toList();
  }

  Future<List<StopModel>> getStopsByMode(TransportMode mode) async {
    final stops = await _stopsDao.getStopsByMode(mode);
    return stops.map(_mapToDomain).toList();
  }

  StopModel _mapToDomain(Stop stop) {
    return StopModel(
      id: stop.id,
      name: stop.name,
      lat: stop.lat,
      lon: stop.lon,
      transportMode: stop.transportMode,
      operatorId: stop.operatorId,
    );
  }
}
