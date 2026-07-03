import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/features/schedule/data/schedule_repository.dart';
import '../../fixtures/test_seed_data.dart';

void main() {
  late AppDatabase db;
  late ScheduleRepository repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await seedTestData(db);
    repository = ScheduleRepository(db.stopTimesDao);
  });

  tearDown(() async {
    await db.close();
  });

  group('ScheduleRepository', () {
    test('getUpcomingTimesForStop resolves DayType and filters times', () async {
      // 2024-05-21 is a Tuesday (Weekday)
      final now = DateTime(2024, 5, 21, 10, 0, 0);

      final upcoming = await repository.getUpcomingTimesForStop('stop1', now);

      expect(upcoming.length, 2);
      expect(upcoming[0].arrivalTime, '12:00:00');
      expect(upcoming[1].arrivalTime, '23:55:00');
    });

    test('getUpcomingTimesForStop handles Saturday', () async {
      // 2024-05-25 is a Saturday
      final now = DateTime(2024, 5, 25, 10, 0, 0);

      final upcoming = await repository.getUpcomingTimesForStop('stop1', now);

      expect(upcoming.length, 1);
      expect(upcoming[0].arrivalTime, '14:00:00');
    });

    test('getUpcomingTimesForStop handles Sunday (Holiday)', () async {
      // 2024-05-26 is a Sunday
      final now = DateTime(2024, 5, 26, 09, 0, 0);

      final upcoming = await repository.getUpcomingTimesForStop('stop1', now);

      expect(upcoming.length, 2);
      expect(upcoming[0].arrivalTime, '10:00:00');
      expect(upcoming[1].arrivalTime, '18:00:00');
    });

    test('getUpcomingTimesForStop returns empty for non-existent stop', () async {
      final now = DateTime(2024, 5, 21, 10, 0, 0);
      final upcoming = await repository.getUpcomingTimesForStop('non_existent', now);
      expect(upcoming, isEmpty);
    });
  });
}
