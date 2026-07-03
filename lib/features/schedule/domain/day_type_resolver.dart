import '../../../shared/models/enums.dart';

/// Resolves the [DayType] for a given [date].
///
/// If [date] is in the [holidays] list, it returns [DayType.holiday].
///
/// Decision: Sundays are treated as [DayType.holiday]. In Spain, most transport
/// operators use the same schedules for Sundays and national/local holidays.
DayType resolveDayType(DateTime date, {List<DateTime> holidays = const []}) {
  // Check if it's in the holidays list (ignoring time)
  final isHoliday = holidays.any(
    (h) => h.year == date.year && h.month == date.month && h.day == date.day,
  );

  if (isHoliday || date.weekday == DateTime.sunday) {
    return DayType.holiday;
  } else if (date.weekday == DateTime.saturday) {
    return DayType.saturday;
  } else {
    return DayType.weekday;
  }
}
