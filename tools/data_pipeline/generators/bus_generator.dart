import '../../../lib/database/drift/app_database.dart';
import '../../../lib/shared/models/enums.dart';
import 'base_generator.dart';

class BusGenerator extends TransportDataGenerator {
  BusGenerator(super.db);

  @override
  Future<void> populate() async {
    const operatorId = 'consorcio_cadiz';

    // 1. Operator
    await db.operatorsDao.insertOperator(
      const Operator(
        id: operatorId,
        name: 'Consorcio de Transportes de la Bahía de Cádiz',
        transportMode: TransportMode.bus,
        attributionText: 'Datos proporcionados por el Consorcio',
        licenseUrl: 'https://www.cmtbc.es/',
      ),
    );

    // 2. Stops
    final busStops = [
      const Stop(
        id: 'bus_cadiz_plaza_espana',
        name: 'Plaza de España',
        lat: 36.534,
        lon: -6.293,
        transportMode: TransportMode.bus,
        operatorId: operatorId,
      ),
      const Stop(
        id: 'bus_cadiz_puerta_mar',
        name: 'Hospital Puerta del Mar',
        lat: 36.512,
        lon: -6.279,
        transportMode: TransportMode.bus,
        operatorId: operatorId,
      ),
      const Stop(
        id: 'bus_cadiz_segunda_aguada',
        name: 'Segunda Aguada',
        lat: 36.505,
        lon: -6.273,
        transportMode: TransportMode.bus,
        operatorId: operatorId,
      ),
      const Stop(
        id: 'bus_cadiz_telegrafia',
        name: 'Telegrafía sin Hilos',
        lat: 36.501,
        lon: -6.271,
        transportMode: TransportMode.bus,
        operatorId: operatorId,
      ),
    ];

    for (final stop in busStops) {
      await db.stopsDao.insertStop(stop);
    }

    // 3. Routes
    const routeId = 'M-010';
    await db.routesDao.insertRoute(
      const Route(
        id: routeId,
        name: 'M-010 Cádiz - San Fernando (Norte)',
        operatorId: operatorId,
        transportMode: TransportMode.bus,
        colorHex: '#0055AA',
      ),
    );

    // 4. Trips
    const tripId = 'trip_M010_1';
    await db.tripsDao.insertTrip(
      const Trip(
        id: tripId,
        routeId: routeId,
        direction: Direction.outbound,
      ),
    );

    // 5. Stop Times
    final stopTimes = [
      const StopTime(
        tripId: tripId,
        stopId: 'bus_cadiz_plaza_espana',
        sequence: 1,
        arrivalTime: '08:00:00',
        departureTime: '08:00:00',
        dayType: DayType.weekday,
      ),
      const StopTime(
        tripId: tripId,
        stopId: 'bus_cadiz_puerta_mar',
        sequence: 2,
        arrivalTime: '08:10:00',
        departureTime: '08:10:00',
        dayType: DayType.weekday,
      ),
      const StopTime(
        tripId: tripId,
        stopId: 'bus_cadiz_segunda_aguada',
        sequence: 3,
        arrivalTime: '08:15:00',
        departureTime: '08:15:00',
        dayType: DayType.weekday,
      ),
      const StopTime(
        tripId: tripId,
        stopId: 'bus_cadiz_telegrafia',
        sequence: 4,
        arrivalTime: '08:20:00',
        departureTime: '08:20:00',
        dayType: DayType.weekday,
      ),
    ];

    for (final st in stopTimes) {
      await db.stopTimesDao.insertStopTime(st);
    }

    print('Bus data generated successfully.');
  }
}
