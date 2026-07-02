import '../../shared/models/enums.dart';

DayType getDayType(DateTime date) {
  if (date.weekday == DateTime.sunday) {
    return DayType.holiday;
  } else if (date.weekday == DateTime.saturday) {
    return DayType.saturday;
  } else {
    // Para simplificar, asumimos que festivos nacionales no se calculan aquí 
    // y se tratan como domingo/festivo si el GTFS así lo indica.
    // Una implementación real necesitaría un calendario de festivos.
    return DayType.weekday;
  }
}
