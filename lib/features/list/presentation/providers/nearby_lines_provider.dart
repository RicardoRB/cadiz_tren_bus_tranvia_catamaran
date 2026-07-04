import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../database/drift/database_provider.dart';
import '../../../stops/presentation/providers/stops_provider.dart';
import '../../data/nearby_lines_repository.dart';
import '../../domain/nearby_line_entry.dart';
import '../../../map/presentation/providers/user_location_provider.dart';

part 'nearby_lines_provider.g.dart';

@riverpod
NearbyLinesRepository nearbyLinesRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  final stopsRepo = ref.watch(stopsRepositoryProvider);
  return NearbyLinesRepository(
    stopsRepository: stopsRepo,
    routesDao: db.routesDao,
    stopTimesDao: db.stopTimesDao,
  );
}

@riverpod
Future<List<NearbyLineEntry>> nearbyLines(Ref ref) {
  final userLocation = ref.watch(userLocationProvider);

  if (userLocation.position == null) {
    return Future.value([]);
  }

  final repo = ref.watch(nearbyLinesRepositoryProvider);
  return repo.getNearbyLines(
    userLocation.position!.latitude,
    userLocation.position!.longitude,
  );
}
