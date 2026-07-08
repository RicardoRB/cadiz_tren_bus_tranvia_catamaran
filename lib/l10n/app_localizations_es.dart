// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'CadizTransit';

  @override
  String get mapLabel => 'Mapa';

  @override
  String get mapTooltip => 'Mapa de paradas';

  @override
  String get nearbyLabel => 'Cercanas';

  @override
  String get nearbyTooltip => 'Líneas cercanas';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get themeTitle => 'Tema';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get lightTheme => 'Claro';

  @override
  String get darkTheme => 'Oscuro';

  @override
  String get othersTitle => 'Otros';

  @override
  String get loading => 'Cargando...';

  @override
  String get error => 'Error';

  @override
  String errorWithDetail(String detail) {
    return 'Error: $detail';
  }

  @override
  String get lineNotFound => 'Línea no encontrada';

  @override
  String get stopNotFound => 'Parada no encontrada';

  @override
  String get outbound => 'Ida';

  @override
  String get inbound => 'Vuelta';

  @override
  String get noStopsToShow => 'No hay paradas para mostrar';

  @override
  String get activateLocation => 'Activar ubicación';

  @override
  String get noNearbyLines => 'No hay líneas cercanas';

  @override
  String get retry => 'Reintentar';

  @override
  String get locationPermissionTitle => 'Ubicación necesaria';

  @override
  String get locationPermissionContent =>
      'Para mostrarte las paradas y líneas más cercanas a tu posición, necesitamos acceso a tu ubicación GPS.\n\nTus datos de ubicación no se guardan ni se envían a ningún servidor externo.';

  @override
  String get locationPermissionMapContent =>
      'Para mostrar tu ubicación en el mapa y encontrar paradas cercanas, necesitamos permiso de acceso a la ubicación.';

  @override
  String get locationPermissionTitleSimple => 'Permiso de ubicación';

  @override
  String get notNow => 'AHORA NO';

  @override
  String get allow => 'PERMITIR';

  @override
  String get cancel => 'CANCELAR';

  @override
  String get settings => 'AJUSTES';

  @override
  String get fullSchedule => 'Horario completo';

  @override
  String get noMoreServicesToday => 'No hay más servicios para hoy';

  @override
  String nextDeparture(String time) {
    return 'Próx: $time';
  }

  @override
  String get viewFullSchedule => 'Ver horario completo';

  @override
  String get startTypingToSearch => 'Empieza a escribir para buscar';

  @override
  String get typeAtLeastTwoChars => 'Escribe al menos 2 caracteres';

  @override
  String noResultsFor(String query) {
    return 'No se han encontrado resultados para \"$query\"';
  }

  @override
  String get searchHint => 'Buscar paradas o líneas...';

  @override
  String get lines => 'Líneas';

  @override
  String get stops => 'Paradas';

  @override
  String get lineDetail => 'Detalle de línea';

  @override
  String get stopDetail => 'Detalle de parada';

  @override
  String get viewOnMap => 'Ver en mapa';

  @override
  String get removedFromFavorites => 'Eliminado de favoritos';

  @override
  String get addedToFavorites => 'Añadido a favoritos';

  @override
  String get nextDepartures => 'Próximos pasos';

  @override
  String get today => 'Hoy';

  @override
  String get noStopsForDirection =>
      'No hay paradas registradas para este sentido';

  @override
  String get viewFullDetail => 'Ver detalle completo';

  @override
  String get favorites => 'Favoritos';

  @override
  String get needLocationForNearby =>
      'Necesitamos tu ubicación para mostrar líneas cercanas';

  @override
  String get bus => 'Autobús';

  @override
  String get tram => 'Tranvía';

  @override
  String get commuterRail => 'Cercanías';

  @override
  String get catamaran => 'Catamarán';

  @override
  String get weekday => 'Laborable';

  @override
  String get saturday => 'Sábado';

  @override
  String get holiday => 'Festivo';

  @override
  String get noScheduleForDayType => 'No hay horarios para este tipo de día';

  @override
  String operatorId(String id) {
    return 'Operador ID: $id';
  }

  @override
  String tripId(String id) {
    return 'ID de viaje: $id';
  }

  @override
  String linesOf(String mode) {
    return 'Líneas de $mode';
  }

  @override
  String get mapOfStops => 'Mapa de Paradas';
}
