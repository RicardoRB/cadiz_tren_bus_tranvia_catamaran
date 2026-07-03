import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';
import '../../fixtures/test_seed_data.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    await seedTestData(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('StopTimesDao', () {
    test(
      'getUpcomingStopTimesByStopAndDay filters correctly by time',
      () async {
        // 08:30 is exact match, should include it and later
        final results = await db.stopTimesDao.getUpcomingStopTimesByStopAndDay(
          'stop1',
          DayType.weekday,
          '08:30:00',
        );

        expect(results.length, 3);
        expect(results[0].arrivalTime, '08:30:00');
        expect(results[1].arrivalTime, '12:00:00');
        expect(results[2].arrivalTime, '23:55:00');
      },
    );

    test(
      'getUpcomingStopTimesByStopAndDay returns empty when no more times',
      () async {
        final results = await db.stopTimesDao.getUpcomingStopTimesByStopAndDay(
          'stop1',
          DayType.weekday,
          '23:59:59',
        );

        expect(results, isEmpty);
      },
    );

    test('getUpcomingStopTimesByStopAndDay filters by day type', () async {
      final results = await db.stopTimesDao.getUpcomingStopTimesByStopAndDay(
        'stop1',
        DayType.saturday,
        '00:00:00',
      );

      expect(results.length, 2);
      expect(results[0].arrivalTime, '09:00:00');
      expect(results[1].arrivalTime, '14:00:00');
    });
  });
}
