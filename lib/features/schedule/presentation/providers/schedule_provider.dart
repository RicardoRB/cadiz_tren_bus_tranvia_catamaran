import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../database/drift/database_provider.dart';
import '../../data/schedule_repository.dart';
import '../../../../shared/models/domain/stop_time.dart';
import '../../../../shared/models/enums.dart';

part 'schedule_provider.g.dart';

@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ScheduleRepository(db.stopTimesDao);
}

@riverpod
Future<List<StopTimeModel>> stopSchedule(
  Ref ref,
  String stopId,
  DayType dayType,
) {
  return ref
      .watch(scheduleRepositoryProvider)
      .getScheduleForStop(stopId, dayType);
}

@riverpod
Future<List<StopTimeModel>> upcomingStopTimes(
  Ref ref,
  String stopId,
  DateTime now,
) {
  return ref
      .watch(scheduleRepositoryProvider)
      .getUpcomingTimesForStop(stopId, now);
}
