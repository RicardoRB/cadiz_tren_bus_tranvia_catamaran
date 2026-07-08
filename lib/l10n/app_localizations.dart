import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// El título de la aplicación
  ///
  /// In es, this message translates to:
  /// **'CadizTransit'**
  String get appTitle;

  /// No description provided for @mapLabel.
  ///
  /// In es, this message translates to:
  /// **'Mapa'**
  String get mapLabel;

  /// No description provided for @mapTooltip.
  ///
  /// In es, this message translates to:
  /// **'Mapa de paradas'**
  String get mapTooltip;

  /// No description provided for @nearbyLabel.
  ///
  /// In es, this message translates to:
  /// **'Cercanas'**
  String get nearbyLabel;

  /// No description provided for @nearbyTooltip.
  ///
  /// In es, this message translates to:
  /// **'Líneas cercanas'**
  String get nearbyTooltip;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get settingsTitle;

  /// No description provided for @themeTitle.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get themeTitle;

  /// No description provided for @systemTheme.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get darkTheme;

  /// No description provided for @othersTitle.
  ///
  /// In es, this message translates to:
  /// **'Otros'**
  String get othersTitle;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorWithDetail.
  ///
  /// In es, this message translates to:
  /// **'Error: {detail}'**
  String errorWithDetail(String detail);

  /// No description provided for @lineNotFound.
  ///
  /// In es, this message translates to:
  /// **'Línea no encontrada'**
  String get lineNotFound;

  /// No description provided for @stopNotFound.
  ///
  /// In es, this message translates to:
  /// **'Parada no encontrada'**
  String get stopNotFound;

  /// No description provided for @outbound.
  ///
  /// In es, this message translates to:
  /// **'Ida'**
  String get outbound;

  /// No description provided for @inbound.
  ///
  /// In es, this message translates to:
  /// **'Vuelta'**
  String get inbound;

  /// No description provided for @noStopsToShow.
  ///
  /// In es, this message translates to:
  /// **'No hay paradas para mostrar'**
  String get noStopsToShow;

  /// No description provided for @activateLocation.
  ///
  /// In es, this message translates to:
  /// **'Activar ubicación'**
  String get activateLocation;

  /// No description provided for @noNearbyLines.
  ///
  /// In es, this message translates to:
  /// **'No hay líneas cercanas'**
  String get noNearbyLines;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @locationPermissionTitle.
  ///
  /// In es, this message translates to:
  /// **'Ubicación necesaria'**
  String get locationPermissionTitle;

  /// No description provided for @locationPermissionContent.
  ///
  /// In es, this message translates to:
  /// **'Para mostrarte las paradas y líneas más cercanas a tu posición, necesitamos acceso a tu ubicación GPS.\n\nTus datos de ubicación no se guardan ni se envían a ningún servidor externo.'**
  String get locationPermissionContent;

  /// No description provided for @locationPermissionMapContent.
  ///
  /// In es, this message translates to:
  /// **'Para mostrar tu ubicación en el mapa y encontrar paradas cercanas, necesitamos permiso de acceso a la ubicación.'**
  String get locationPermissionMapContent;

  /// No description provided for @locationPermissionTitleSimple.
  ///
  /// In es, this message translates to:
  /// **'Permiso de ubicación'**
  String get locationPermissionTitleSimple;

  /// No description provided for @notNow.
  ///
  /// In es, this message translates to:
  /// **'AHORA NO'**
  String get notNow;

  /// No description provided for @allow.
  ///
  /// In es, this message translates to:
  /// **'PERMITIR'**
  String get allow;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'CANCELAR'**
  String get cancel;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'AJUSTES'**
  String get settings;

  /// No description provided for @fullSchedule.
  ///
  /// In es, this message translates to:
  /// **'Horario completo'**
  String get fullSchedule;

  /// No description provided for @noMoreServicesToday.
  ///
  /// In es, this message translates to:
  /// **'No hay más servicios para hoy'**
  String get noMoreServicesToday;

  /// No description provided for @nextDeparture.
  ///
  /// In es, this message translates to:
  /// **'Próx: {time}'**
  String nextDeparture(String time);

  /// No description provided for @viewFullSchedule.
  ///
  /// In es, this message translates to:
  /// **'Ver horario completo'**
  String get viewFullSchedule;

  /// No description provided for @startTypingToSearch.
  ///
  /// In es, this message translates to:
  /// **'Empieza a escribir para buscar'**
  String get startTypingToSearch;

  /// No description provided for @typeAtLeastTwoChars.
  ///
  /// In es, this message translates to:
  /// **'Escribe al menos 2 caracteres'**
  String get typeAtLeastTwoChars;

  /// No description provided for @noResultsFor.
  ///
  /// In es, this message translates to:
  /// **'No se han encontrado resultados para \"{query}\"'**
  String noResultsFor(String query);

  /// No description provided for @searchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar paradas o líneas...'**
  String get searchHint;

  /// No description provided for @lines.
  ///
  /// In es, this message translates to:
  /// **'Líneas'**
  String get lines;

  /// No description provided for @stops.
  ///
  /// In es, this message translates to:
  /// **'Paradas'**
  String get stops;

  /// No description provided for @lineDetail.
  ///
  /// In es, this message translates to:
  /// **'Detalle de línea'**
  String get lineDetail;

  /// No description provided for @stopDetail.
  ///
  /// In es, this message translates to:
  /// **'Detalle de parada'**
  String get stopDetail;

  /// No description provided for @viewOnMap.
  ///
  /// In es, this message translates to:
  /// **'Ver en mapa'**
  String get viewOnMap;

  /// No description provided for @removedFromFavorites.
  ///
  /// In es, this message translates to:
  /// **'Eliminado de favoritos'**
  String get removedFromFavorites;

  /// No description provided for @addedToFavorites.
  ///
  /// In es, this message translates to:
  /// **'Añadido a favoritos'**
  String get addedToFavorites;

  /// No description provided for @nextDepartures.
  ///
  /// In es, this message translates to:
  /// **'Próximos pasos'**
  String get nextDepartures;

  /// No description provided for @today.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get today;

  /// No description provided for @noStopsForDirection.
  ///
  /// In es, this message translates to:
  /// **'No hay paradas registradas para este sentido'**
  String get noStopsForDirection;

  /// No description provided for @viewFullDetail.
  ///
  /// In es, this message translates to:
  /// **'Ver detalle completo'**
  String get viewFullDetail;

  /// No description provided for @favorites.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favorites;

  /// No description provided for @needLocationForNearby.
  ///
  /// In es, this message translates to:
  /// **'Necesitamos tu ubicación para mostrar líneas cercanas'**
  String get needLocationForNearby;

  /// No description provided for @bus.
  ///
  /// In es, this message translates to:
  /// **'Autobús'**
  String get bus;

  /// No description provided for @tram.
  ///
  /// In es, this message translates to:
  /// **'Tranvía'**
  String get tram;

  /// No description provided for @commuterRail.
  ///
  /// In es, this message translates to:
  /// **'Cercanías'**
  String get commuterRail;

  /// No description provided for @catamaran.
  ///
  /// In es, this message translates to:
  /// **'Catamarán'**
  String get catamaran;

  /// No description provided for @weekday.
  ///
  /// In es, this message translates to:
  /// **'Laborable'**
  String get weekday;

  /// No description provided for @saturday.
  ///
  /// In es, this message translates to:
  /// **'Sábado'**
  String get saturday;

  /// No description provided for @holiday.
  ///
  /// In es, this message translates to:
  /// **'Festivo'**
  String get holiday;

  /// No description provided for @noScheduleForDayType.
  ///
  /// In es, this message translates to:
  /// **'No hay horarios para este tipo de día'**
  String get noScheduleForDayType;

  /// No description provided for @operatorId.
  ///
  /// In es, this message translates to:
  /// **'Operador ID: {id}'**
  String operatorId(String id);

  /// No description provided for @tripId.
  ///
  /// In es, this message translates to:
  /// **'ID de viaje: {id}'**
  String tripId(String id);

  /// No description provided for @linesOf.
  ///
  /// In es, this message translates to:
  /// **'Líneas de {mode}'**
  String linesOf(String mode);

  /// No description provided for @mapOfStops.
  ///
  /// In es, this message translates to:
  /// **'Mapa de Paradas'**
  String get mapOfStops;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
