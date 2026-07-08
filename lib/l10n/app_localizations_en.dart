// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CadizTransit';

  @override
  String get mapLabel => 'Map';

  @override
  String get mapTooltip => 'Stops map';

  @override
  String get nearbyLabel => 'Nearby';

  @override
  String get nearbyTooltip => 'Nearby lines';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeTitle => 'Theme';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get othersTitle => 'Others';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String errorWithDetail(String detail) {
    return 'Error: $detail';
  }

  @override
  String initDatabaseError(String error) {
    return 'Error initializing database: $error';
  }

  @override
  String get lineNotFound => 'Line not found';

  @override
  String get stopNotFound => 'Stop not found';

  @override
  String get outbound => 'Outbound';

  @override
  String get inbound => 'Inbound';

  @override
  String get noStopsToShow => 'No stops to show';

  @override
  String get activateLocation => 'Activate location';

  @override
  String get noNearbyLines => 'No nearby lines';

  @override
  String get retry => 'Retry';

  @override
  String get locationPermissionTitle => 'Location needed';

  @override
  String get locationPermissionContent =>
      'To show you the stops and lines closest to your position, we need access to your GPS location.\n\nYour location data is not stored or sent to any external server.';

  @override
  String get locationPermissionMapContent =>
      'To show your location on the map and find nearby stops, we need location access permission.';

  @override
  String get locationPermissionTitleSimple => 'Location permission';

  @override
  String get notNow => 'NOT NOW';

  @override
  String get allow => 'ALLOW';

  @override
  String get cancel => 'CANCEL';

  @override
  String get settings => 'SETTINGS';

  @override
  String get fullSchedule => 'Full schedule';

  @override
  String get noMoreServicesToday => 'No more services for today';

  @override
  String nextDeparture(String time) {
    return 'Next: $time';
  }

  @override
  String get viewFullSchedule => 'View full schedule';

  @override
  String get startTypingToSearch => 'Start typing to search';

  @override
  String get typeAtLeastTwoChars => 'Type at least 2 characters';

  @override
  String noResultsFor(String query) {
    return 'No results found for \"$query\"';
  }

  @override
  String get searchHint => 'Search stops or lines...';

  @override
  String get lines => 'Lines';

  @override
  String get stops => 'Stops';

  @override
  String get lineDetail => 'Line detail';

  @override
  String get stopDetail => 'Stop detail';

  @override
  String get viewOnMap => 'View on map';

  @override
  String get removedFromFavorites => 'Removed from favorites';

  @override
  String get addedToFavorites => 'Added to favorites';

  @override
  String get nextDepartures => 'Next departures';

  @override
  String get today => 'Today';

  @override
  String get noStopsForDirection => 'No stops registered for this direction';

  @override
  String get viewFullDetail => 'View full detail';

  @override
  String get favorites => 'Favorites';

  @override
  String get all => 'All';

  @override
  String get filterTransportModes => 'Filter transport modes';

  @override
  String get searchLineHint => 'Search line...';

  @override
  String get noLinesAvailable => 'No lines available';

  @override
  String get needLocationForNearby =>
      'We need your location to show nearby lines';

  @override
  String get bus => 'Bus';

  @override
  String get tram => 'Tram';

  @override
  String get commuterRail => 'Commuter Rail';

  @override
  String get catamaran => 'Catamaran';

  @override
  String get weekday => 'Weekday';

  @override
  String get saturday => 'Saturday';

  @override
  String get holiday => 'Holiday';

  @override
  String get noScheduleForDayType => 'No schedule for this day type';

  @override
  String operatorId(String id) {
    return 'Operator: $id';
  }

  @override
  String tripId(String id) {
    return 'Trip ID: $id';
  }

  @override
  String linesOf(String mode) {
    return '$mode lines';
  }

  @override
  String get mapOfStops => 'Stops Map';
}
