import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../database/drift/database_provider.dart';
import '../../data/schedule_repository.dart';

part 'schedule_provider.g.dart';

@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return ScheduleRepository(db.stopTimesDao);
}
