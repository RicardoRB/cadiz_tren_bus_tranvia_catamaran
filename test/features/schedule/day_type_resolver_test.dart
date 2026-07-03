import 'package:flutter_test/flutter_test.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/features/schedule/domain/day_type_resolver.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';

void main() {
  group('DayTypeResolver', () {
    test('Tuesday resolves to weekday', () {
      final date = DateTime(2024, 5, 21); // Tuesday
      expect(resolveDayType(date), DayType.weekday);
    });

    test('Saturday resolves to saturday', () {
      final date = DateTime(2024, 5, 25); // Saturday
      expect(resolveDayType(date), DayType.saturday);
    });

    test('Sunday resolves to holiday', () {
      final date = DateTime(2024, 5, 26); // Sunday
      expect(resolveDayType(date), DayType.holiday);
    });

    test('Date in holidays list resolves to holiday', () {
      final date = DateTime(
        2024,
        5,
        1,
      ); // Wednesday, but if we pass it as holiday...
      final holidays = [DateTime(2024, 5, 1)];
      expect(resolveDayType(date, holidays: holidays), DayType.holiday);
    });

    test('Date not in holidays list resolves normally', () {
      final date = DateTime(2024, 5, 22); // Wednesday
      final holidays = [DateTime(2024, 5, 1)];
      expect(resolveDayType(date, holidays: holidays), DayType.weekday);
    });
  });
}
