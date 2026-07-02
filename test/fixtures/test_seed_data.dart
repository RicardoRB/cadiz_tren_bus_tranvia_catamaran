import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';

Future<void> seedTestData(AppDatabase db) async {
  // Operators
  await db.operatorsDao.insertOperator(Operator(
    id: 'op1',
    name: 'Operator 1',
    transportMode: TransportMode.bus,
  ));

  // Stops
  await db.stopsDao.insertStop(Stop(
    id: 'stop1',
    name: 'Stop 1',
    lat: 36.5,
    lon: -6.2,
    transportMode: TransportMode.bus,
    operatorId: 'op1',
  ));

  // Routes
  await db.routesDao.insertRoute(Route(
    id: 'route1',
    name: 'Route 1',
    operatorId: 'op1',
    transportMode: TransportMode.bus,
  ));

  // Trips
  await db.tripsDao.insertTrip(Trip(
    id: 'trip_weekday_1',
    routeId: 'route1',
    direction: Direction.outbound,
  ));

  await db.tripsDao.insertTrip(Trip(
    id: 'trip_saturday_1',
    routeId: 'route1',
    direction: Direction.outbound,
  ));

  await db.tripsDao.insertTrip(Trip(
    id: 'trip_holiday_1',
    routeId: 'route1',
    direction: Direction.outbound,
  ));

  // Stop Times
  final stopTimes = [
    // Weekday schedules
    StopTime(tripId: 'trip_weekday_1', stopId: 'stop1', sequence: 1, arrivalTime: '07:00:00', departureTime: '07:00:00', dayType: DayType.weekday),
    StopTime(tripId: 'trip_weekday_1', stopId: 'stop1', sequence: 2, arrivalTime: '08:30:00', departureTime: '08:30:00', dayType: DayType.weekday),
    StopTime(tripId: 'trip_weekday_1', stopId: 'stop1', sequence: 3, arrivalTime: '12:00:00', departureTime: '12:00:00', dayType: DayType.weekday),
    StopTime(tripId: 'trip_weekday_1', stopId: 'stop1', sequence: 4, arrivalTime: '23:55:00', departureTime: '23:55:00', dayType: DayType.weekday),

    // Saturday schedules
    StopTime(tripId: 'trip_saturday_1', stopId: 'stop1', sequence: 1, arrivalTime: '09:00:00', departureTime: '09:00:00', dayType: DayType.saturday),
    StopTime(tripId: 'trip_saturday_1', stopId: 'stop1', sequence: 2, arrivalTime: '14:00:00', departureTime: '14:00:00', dayType: DayType.saturday),

    // Holiday schedules
    StopTime(tripId: 'trip_holiday_1', stopId: 'stop1', sequence: 1, arrivalTime: '10:00:00', departureTime: '10:00:00', dayType: DayType.holiday),
    StopTime(tripId: 'trip_holiday_1', stopId: 'stop1', sequence: 2, arrivalTime: '18:00:00', departureTime: '18:00:00', dayType: DayType.holiday),
  ];

  for (final st in stopTimes) {
    await db.stopTimesDao.insertStopTime(st);
  }
}
