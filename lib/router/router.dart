import 'package:go_router/go_router.dart';
import 'shell_scaffold.dart';
import '../features/home/presentation/screens/splash_screen.dart';
import '../features/map/presentation/screens/map_screen.dart';
import '../features/lines/presentation/screens/line_detail_screen.dart';
import '../features/lines/presentation/screens/lines_list_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/stops/presentation/screens/stop_detail_screen.dart';
import '../features/list/presentation/screens/nearby_lines_screen.dart';
import '../shared/models/enums.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ShellScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/map',
              builder: (context, state) => const MapScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/nearby',
              builder: (context, state) => const NearbyLinesScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/stop-on-map',
      builder: (context, state) {
        final stopId = state.uri.queryParameters['stopId'];
        return MapScreen(focusStopId: stopId);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/lines/:mode',
      builder: (context, state) {
        final modeString = state.pathParameters['mode']!;
        final mode = TransportMode.values.byName(modeString);
        return LinesListScreen(mode: mode);
      },
    ),
    GoRoute(
      path: '/lines/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return LineDetailScreen(routeId: id);
      },
    ),
    GoRoute(
      path: '/stops/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return StopDetailScreen(stopId: id);
      },
    ),
    GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
  ],
);
