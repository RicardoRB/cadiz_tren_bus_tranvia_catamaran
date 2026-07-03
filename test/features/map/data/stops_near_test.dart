import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
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

  test('getStopsNear returns stops within bounding box', () async {
    // Cadiz center approx 36.52, -6.29
    await db.stopsDao.insertStop(Stop(
      id: 'stop-near',
      name: 'Near Stop',
      lat: 36.521,
      lon: -6.291,
      transportMode: TransportMode.bus,
      operatorId: 'op1',
    ));

    await db.stopsDao.insertStop(Stop(
      id: 'stop-far',
      name: 'Far Stop',
      lat: 36.650, // > 10km away
      lon: -6.200,
      transportMode: TransportMode.bus,
      operatorId: 'op1',
    ));

    final nearStops = await db.stopsDao.getStopsNear(36.52, -6.29, 2.0);

    expect(nearStops.length, 1);
    expect(nearStops.first.id, 'stop-near');
  });
}
