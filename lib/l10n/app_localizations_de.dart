// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'CadizTransit';

  @override
  String get mapLabel => 'Karte';

  @override
  String get mapTooltip => 'Haltestellenkarte';

  @override
  String get nearbyLabel => 'In der Nähe';

  @override
  String get nearbyTooltip => 'Linien in der Nähe';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get themeTitle => 'Design';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Hell';

  @override
  String get darkTheme => 'Dunkel';

  @override
  String get othersTitle => 'Sonstiges';

  @override
  String get loading => 'Laden...';

  @override
  String get error => 'Fehler';

  @override
  String errorWithDetail(String detail) {
    return 'Fehler: $detail';
  }

  @override
  String initDatabaseError(String error) {
    return 'Fehler beim Initialisieren der Datenbank: $error';
  }

  @override
  String get lineNotFound => 'Linie nicht gefunden';

  @override
  String get stopNotFound => 'Haltestelle nicht gefunden';

  @override
  String get outbound => 'Hinfahrt';

  @override
  String get inbound => 'Rückfahrt';

  @override
  String get noStopsToShow => 'Keine Haltestellen zum Anzeigen';

  @override
  String get activateLocation => 'Standort aktivieren';

  @override
  String get noNearbyLines => 'Keine Linien in der Nähe';

  @override
  String get retry => 'Wiederholen';

  @override
  String get locationPermissionTitle => 'Standort benötigt';

  @override
  String get locationPermissionContent =>
      'Um Ihnen die Haltestellen und Linien in Ihrer Nähe anzuzeigen, benötigen wir Zugriff auf Ihren GPS-Standort.\n\nIhre Standortdaten werden nicht gespeichert oder an externe Server gesendet.';

  @override
  String get locationPermissionMapContent =>
      'Um Ihren Standort auf der Karte anzuzeigen und Haltestellen in der Nähe zu finden, benötigen wir die Erlaubnis zum Standortzugriff.';

  @override
  String get locationPermissionTitleSimple => 'Standorterlaubnis';

  @override
  String get notNow => 'JETZT NICHT';

  @override
  String get allow => 'ERLAUBEN';

  @override
  String get cancel => 'ABBRECHEN';

  @override
  String get settings => 'EINSTELLUNGEN';

  @override
  String get fullSchedule => 'Vollständiger Fahrplan';

  @override
  String get noMoreServicesToday => 'Keine weiteren Fahrten heute';

  @override
  String nextDeparture(String time) {
    return 'Nächste: $time';
  }

  @override
  String get viewFullSchedule => 'Vollständigen Fahrplan ansehen';

  @override
  String get startTypingToSearch => 'Tippen Sie, um zu suchen';

  @override
  String get typeAtLeastTwoChars => 'Geben Sie mindestens 2 Zeichen ein';

  @override
  String noResultsFor(String query) {
    return 'Keine Ergebnisse für \"$query\" gefunden';
  }

  @override
  String get searchHint => 'Haltestellen oder Linien suchen...';

  @override
  String get lines => 'Linien';

  @override
  String get stops => 'Haltestellen';

  @override
  String get lineDetail => 'Liniendetails';

  @override
  String get stopDetail => 'Haltestellendetails';

  @override
  String get viewOnMap => 'Auf Karte anzeigen';

  @override
  String get removedFromFavorites => 'Aus Favoriten entfernt';

  @override
  String get addedToFavorites => 'Zu Favoriten hinzugefügt';

  @override
  String get nextDepartures => 'Nächste Abfahrten';

  @override
  String get today => 'Heute';

  @override
  String get noStopsForDirection =>
      'Keine Haltestellen für diese Richtung registriert';

  @override
  String get viewFullDetail => 'Alle Details anzeigen';

  @override
  String get favorites => 'Favoriten';

  @override
  String get all => 'Alle';

  @override
  String get filterTransportModes => 'Verkehrsmittel filtern';

  @override
  String get searchLineHint => 'Linie suchen...';

  @override
  String get noLinesAvailable => 'Keine Linien verfügbar';

  @override
  String get needLocationForNearby =>
      'Wir benötigen Ihren Standort, um Linien in der Nähe anzuzeigen';

  @override
  String get bus => 'Bus';

  @override
  String get tram => 'Straßenbahn';

  @override
  String get commuterRail => 'S-Bahn';

  @override
  String get catamaran => 'Katamaran';

  @override
  String get weekday => 'Werktag';

  @override
  String get saturday => 'Samstag';

  @override
  String get holiday => 'Feiertag';

  @override
  String get noScheduleForDayType => 'Kein Fahrplan für diesen Tagestyp';

  @override
  String operatorId(String id) {
    return 'Betreiber: $id';
  }

  @override
  String tripId(String id) {
    return 'Fahrt-ID: $id';
  }

  @override
  String linesOf(String mode) {
    return '$mode-Linien';
  }

  @override
  String get mapOfStops => 'Haltestellenkarte';
}
