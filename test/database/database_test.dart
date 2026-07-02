import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('can insert and retrieve an operator', () async {
    final op = Operator(
      id: 'ctmc',
      name: 'Consorcio',
      transportMode: TransportMode.bus,
    );

    await db.operatorsDao.insertOperator(op);
    final retrieved = await db.operatorsDao.getOperatorById('ctmc');

    expect(retrieved?.name, 'Consorcio');
    expect(retrieved?.transportMode, TransportMode.bus);
  });

  test('can retrieve schedule for a stop and day type', () async {
    // Setup data
    await db.operatorsDao.insertOperator(Operator(id: 'op1', name: 'Op 1', transportMode: TransportMode.tram));
    await db.stopsDao.insertStop(Stop(id: 's1', name: 'Stop 1', lat: 36.5, lon: -6.2, transportMode: TransportMode.tram, operatorId: 'op1'));
    await db.routesDao.insertRoute(Route(id: 'r1', name: 'Route 1', operatorId: 'op1', transportMode: TransportMode.tram));
    await db.tripsDao.insertTrip(Trip(id: 't1', routeId: 'r1', direction: Direction.outbound));
    
    await db.stopTimesDao.insertStopTime(StopTime(
      tripId: 't1',
      stopId: 's1',
      sequence: 1,
      arrivalTime: '08:00:00',
      departureTime: '08:05:00',
      dayType: DayType.weekday,
    ));

    final schedule = await db.stopTimesDao.getStopTimesByStopAndDay('s1', DayType.weekday);
    expect(schedule.length, 1);
    expect(schedule.first.arrivalTime, '08:00:00');

    final emptySchedule = await db.stopTimesDao.getStopTimesByStopAndDay('s1', DayType.saturday);
    expect(emptySchedule, isEmpty);
  });
}
