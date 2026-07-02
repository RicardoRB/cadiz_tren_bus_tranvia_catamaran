import '../../../database/drift/app_database.dart';
import '../../../database/drift/daos/stop_times_dao.dart';
import '../../../shared/models/domain/stop_time.dart';
import '../../../shared/models/enums.dart';
import '../domain/day_type_resolver.dart';

class ScheduleRepository {
  final StopTimesDao _stopTimesDao;

  ScheduleRepository(this._stopTimesDao);

  Future<List<StopTimeModel>> getScheduleForStop(String stopId, DayType dayType) async {
    final stopTimes = await _stopTimesDao.getStopTimesByStopAndDay(stopId, dayType);
    return stopTimes.map(_mapToDomain).toList();
  }

  Future<List<StopTimeModel>> getUpcomingTimesForStop(String stopId, DateTime now) async {
    final dayType = resolveDayType(now);
    final timeString = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    final stopTimes = await _stopTimesDao.getUpcomingStopTimesByStopAndDay(stopId, dayType, timeString);
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
