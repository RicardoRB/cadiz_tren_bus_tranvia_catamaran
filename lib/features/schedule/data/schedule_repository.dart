import '../../../database/drift/app_database.dart';
import '../../../database/drift/daos/stop_times_dao.dart';
import '../../../shared/models/domain/stop_time.dart';
import '../../../shared/models/enums.dart';

class ScheduleRepository {
  final StopTimesDao _stopTimesDao;

  ScheduleRepository(this._stopTimesDao);

  Future<List<StopTimeModel>> getScheduleForStop(
    String stopId,
    DayType dayType,
  ) async {
    final stopTimes = await _stopTimesDao.getStopTimesByStopAndDay(
      stopId,
      dayType,
    );
    return stopTimes.map(_mapToDomain).toList();
  }

  StopTimeModel _mapToDomain(StopTime st) {
    return StopTimeModel(
      tripId: st.tripId,
      stopId: st.stopId,
      sequence: st.sequence,
      arrivalTime: st.arrivalTime,
      departureTime: st.departureTime,
      dayType: st.dayType,
    );
  }
}
