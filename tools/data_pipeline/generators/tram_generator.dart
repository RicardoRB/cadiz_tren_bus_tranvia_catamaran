import 'dart:convert';
import 'package:cadiz_tren_bus_tranvia_catamaran/database/drift/app_database.dart';
import 'package:cadiz_tren_bus_tranvia_catamaran/shared/models/enums.dart';
import 'base_generator.dart';

class TramGenerator extends TransportDataGenerator {
  TramGenerator(super.db);

  // JSON schedule data as a string constant for easy maintenance
  static const String _tramScheduleJson = '''
[
  {
    "parada": "PELAGATOS",
    "coordenadas": {
      "latitud": 36.6723,
      "longitud": -5.4239
    },
    "horario": {
      "lunes": "5:20",
      "martes": "5:54",
      "miercoles": "6:44",
      "jueves": "7:44",
      "viernes": "8:42",
      "sabado": "6:24",
      "domingo": "7:02",
      "festivo": "13:42"
    }
  },
  {
    "parada": "LA HOYA",
    "coordenadas": {
      "latitud": 36.6733,
      "longitud": -5.4201
    },
    "horario": {
      "lunes": "5:22",
      "martes": "5:56",
      "miercoles": "6:46",
      "jueves": "7:46",
      "viernes": "8:44",
      "sabado": "6:26",
      "domingo": "7:04",
      "festivo": "13:44"
    }
  },
  {
    "parada": "REYES CATÓLICOS",
    "coordenadas": {
      "latitud": 36.6719,
      "longitud": -5.4230
    },
    "horario": {
      "lunes": "5:24",
      "martes": "5:58",
      "miercoles": "6:48",
      "jueves": "7:48",
      "viernes": "8:46",
      "sabado": "6:28",
      "domingo": "7:06",
      "festivo": "13:46"
    }
  },
  {
    "parada": "NTRA. SRA. DE LOS REMEDIOS",
    "coordenadas": {
      "latitud": 36.6735,
      "longitud": -5.4225
    },
    "horario": {
      "lunes": "5:27",
      "martes": "6:01",
      "miercoles": "6:51",
      "jueves": "7:51",
      "viernes": "8:49",
      "sabado": "6:31",
      "domingo": "7:08",
      "festivo": "13:49"
    }
  },
  {
    "parada": "ALAMEDA",
    "coordenadas": {
      "latitud": 36.6752,
      "longitud": -5.4228
    },
    "horario": {
      "lunes": "5:30",
      "martes": "6:04",
      "miercoles": "6:54",
      "jueves": "7:54",
      "viernes": "8:52",
      "sabado": "6:34",
      "domingo": "7:10",
      "festivo": "13:52"
    }
  },
  {
    "parada": "SOLANO",
    "coordenadas": {
      "latitud": 36.6761,
      "longitud": -5.4215
    },
    "horario": {
      "lunes": "5:32",
      "martes": "6:06",
      "miercoles": "6:56",
      "jueves": "7:56",
      "viernes": "8:54",
      "sabado": "6:36",
      "domingo": "7:12",
      "festivo": "13:54"
    }
  },
  {
    "parada": "MARQUESADO",
    "coordenadas": {
      "latitud": 36.6763,
      "longitud": -5.4208
    },
    "horario": {
      "lunes": "5:36",
      "martes": "6:09",
      "miercoles": "6:59",
      "jueves": "7:59",
      "viernes": "8:57",
      "sabado": "6:39",
      "domingo": "7:14",
      "festivo": "13:57"
    }
  },
  {
    "parada": "PINAR DE LOS FRANCESES",
    "coordenadas": {
      "latitud": 36.6767,
      "longitud": -5.4216
    },
    "horario": {
      "lunes": "5:42",
      "martes": "6:14",
      "miercoles": "7:04",
      "jueves": "8:04",
      "viernes": "9:02",
      "sabado": "6:44",
      "domingo": "7:17",
      "festivo": "14:02"
    }
  },
  {
    "parada": "TRES CAMINOS",
    "coordenadas": {
      "latitud": 36.6768,
      "longitud": -5.4215
    },
    "horario": {
      "lunes": "5:46",
      "martes": "6:18",
      "miercoles": "7:08",
      "jueves": "8:08",
      "viernes": "9:06",
      "sabado": "6:46",
      "domingo": "7:20",
      "festivo": "14:06"
    }
  },
  {
    "parada": "VENTA DE VARGAS",
    "coordenadas": {
      "latitud": 36.6766,
      "longitud": -5.4218
    },
    "horario": {
      "lunes": "5:50",
      "martes": "6:22",
      "miercoles": "7:12",
      "jueves": "8:12",
      "viernes": "9:10",
      "sabado": "6:52",
      "domingo": "7:23",
      "festivo": "14:10"
    }
  },
  {
    "parada": "PLAZA DE LA IGLESIA",
    "coordenadas": {
      "latitud": 36.6760,
      "longitud": -5.4222
    },
    "horario": {
      "lunes": "5:52",
      "martes": "6:24",
      "miercoles": "7:14",
      "jueves": "8:14",
      "viernes": "9:12",
      "sabado": "6:54",
      "domingo": "7:27",
      "festivo": "14:12"
    }
  },
  {
    "parada": "PLAZA DEL REY",
    "coordenadas": {
      "latitud": 36.6758,
      "longitud": -5.4232
    },
    "horario": {
      "lunes": "5:56",
      "martes": "6:28",
      "miercoles": "7:18",
      "jueves": "8:18",
      "viernes": "9:16",
      "sabado": "6:58",
      "domingo": "7:30",
      "festivo": "14:16"
    }
  },
  {
    "parada": "COMPAÑÍA DE MARÍA",
    "coordenadas": {
      "latitud": 36.6764,
      "longitud": -5.4226
    },
    "horario": {
      "lunes": "5:59",
      "martes": "6:31",
      "miercoles": "7:21",
      "jueves": "8:21",
      "viernes": "9:19",
      "sabado": "7:01",
      "domingo": "7:34",
      "festivo": "14:20"
    }
  },
  {
    "parada": "PLAZA DEL CARMEN",
    "coordenadas": {
      "latitud": 36.6762,
      "longitud": -5.4228
    },
    "horario": {
      "lunes": "6:02",
      "martes": "6:34",
      "miercoles": "7:24",
      "jueves": "8:24",
      "viernes": "9:22",
      "sabado": "7:04",
      "domingo": "7:37",
      "festivo": "14:24"
    }
  },
  {
    "parada": "SANTO ENTIERRO",
    "coordenadas": {
      "latitud": 36.6765,
      "longitud": -5.4228
    },
    "horario": {
      "lunes": "6:05",
      "martes": "6:36",
      "miercoles": "7:27",
      "jueves": "8:27",
      "viernes": "9:25",
      "sabado": "7:07",
      "domingo": "7:40",
      "festivo": "14:27"
    }
  },
  {
    "parada": "ARDILA",
    "coordenadas": {
      "latitud": 36.6766,
      "longitud": -5.4225
    },
    "horario": {
      "lunes": "6:08",
      "martes": "6:39",
      "miercoles": "7:30",
      "jueves": "8:30",
      "viernes": "9:28",
      "sabado": "7:10",
      "domingo": "7:43",
      "festivo": "14:31"
    }
  },
  {
    "parada": "RIO ARILLO",
    "coordenadas": {
      "latitud": 36.6770,
      "longitud": -5.4221
    },
    "horario": {
      "lunes": "6:11",
      "martes": "6:43",
      "miercoles": "7:34",
      "jueves": "8:34",
      "viernes": "9:32",
      "sabado": "7:12",
      "domingo": "7:46",
      "festivo": "14:35"
    }
  },
  {
    "parada": "CORTADURA",
    "coordenadas": {
      "latitud": 36.6775,
      "longitud": -5.4224
    },
    "horario": {
      "lunes": "6:17",
      "martes": "6:46",
      "miercoles": "7:37",
      "jueves": "8:37",
      "viernes": "9:34",
      "sabado": "7:14",
      "domingo": "7:50",
      "festivo": "14:37"
    }
  },
  {
    "parada": "ESTADIO",
    "coordenadas": {
      "latitud": 36.6795,
      "longitud": -5.4210
    },
    "horario": {
      "lunes": "6:20",
      "martes": "6:49",
      "miercoles": "7:40",
      "jueves": "8:41",
      "viernes": "9:38",
      "sabado": "7:17",
      "domingo": "7:55",
      "festivo": "14:40"
    }
  },
  {
    "parada": "SEGUNDA AGUADA",
    "coordenadas": {
      "latitud": 36.6799,
      "longitud": -5.4210
    },
    "horario": {
      "lunes": "6:23",
      "martes": "6:52",
      "miercoles": "7:43",
      "jueves": "8:45",
      "viernes": "9:43",
      "sabado": "7:20",
      "domingo": "7:58",
      "festivo": "14:43"
    }
  },
  {
    "parada": "SAN SEVERIANO",
    "coordenadas": {
      "latitud": 36.6796,
      "longitud": -5.4210
    },
    "horario": {
      "lunes": "6:27",
      "martes": "6:54",
      "miercoles": "7:46",
      "jueves": "8:49",
      "viernes": "9:46",
      "sabado": "7:23",
      "domingo": "8:00",
      "festivo": "14:47"
    }
  },
  {
    "parada": "CADIZ",
    "coordenadas": {
      "latitud": 36.6728,
      "longitud": -5.4223
    },
    "horario": {
      "lunes": "6:30",
      "martes": "6:58",
      "miercoles": "7:50",
      "jueves": "8:52",
      "viernes": "9:52",
      "sabado": "7:27",
      "domingo": "8:04",
      "festivo": "14:50"
    }
  }
]
  ''';

  @override
  Future<void> populate() async {
    const operatorId = 'tram_cadiz';

    // 1. Operator
    await db.operatorsDao.insertOperator(
      const Operator(
        id: operatorId,
        name: 'Tranvía de Cádiz',
        transportMode: TransportMode.tram,
        // Ensure this enum exists in your enums.dart
        attributionText: 'Datos proporcionados por el Tranvía de Cádiz',
        licenseUrl: 'https://tranviadecadiz.es/',
      ),
    );

    // 2. Parse JSON and generate Stops
    final List<dynamic> stopsData = jsonDecode(_tramScheduleJson);

    final tramStops = stopsData.map((dynamic e) {
      final map = e as Map<String, dynamic>;
      final coord = map['coordenadas'] as Map<String, dynamic>;

      // Generate a database-safe ID from the stop name
      final cleanName = map['parada'].toLowerCase().replaceAll(
        RegExp(r'[\s.]'),
        '_',
      );

      return Stop(
        id: 'tram_$cleanName',
        name: map['parada'],
        lat: (coord['latitud'] as num).toDouble(),
        lon: (coord['longitud'] as num).toDouble(),
        transportMode: TransportMode.tram,
        operatorId: operatorId,
      );
    }).toList();

    for (final stop in tramStops) {
      await db.stopsDao.insertStop(stop);
    }

    // 3. Route
    const routeId = 'T-01';
    await db.routesDao.insertRoute(
      const Route(
        id: routeId,
        name: 'Tranvía de Cádiz - Línea Principal',
        operatorId: operatorId,
        transportMode: TransportMode.tram,
        colorHex: '#FFD700', // Amarillo/Oro típico del tranvía
      ),
    );

    // 4. Trip
    const tripId = 'trip_T01_1';
    await db.tripsDao.insertTrip(
      const Trip(id: tripId, routeId: routeId, direction: Direction.outbound),
    );

    // 5. Stop Times
    final List<StopTime> stopTimes = [];

    for (int i = 0; i < tramStops.length; i++) {
      final stopData = stopsData[i] as Map<String, dynamic>;
      final horario = stopData['horario'] as Map<String, dynamic>;

      // Use 'lunes' as the representative weekday time
      String? baseTime = (horario['lunes'] as String?);

      // Standardize format to HH:mm:ss if it's currently HH:mm
      if (baseTime != null && baseTime.length == 5) {
        baseTime = '$baseTime:00';
      }

      stopTimes.add(
        StopTime(
          tripId: tripId,
          stopId: tramStops[i].id,
          sequence: i + 1,
          arrivalTime: baseTime ?? '00:00:00',
          departureTime: baseTime ?? '00:00:00',
          dayType: DayType.weekday,
        ),
      );
    }

    for (final st in stopTimes) {
      await db.stopTimesDao.insertStopTime(st);
    }

    logger.info('Tram data generated successfully.');
  }
}
