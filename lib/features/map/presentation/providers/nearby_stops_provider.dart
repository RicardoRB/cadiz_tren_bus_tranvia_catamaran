import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../stops/presentation/providers/stops_provider.dart';
import 'user_location_provider.dart';
import '../../../../shared/models/domain/stop.dart';

part 'nearby_stops_provider.g.dart';

@riverpod
Future<List<StopModel>> nearbyStops(Ref ref) async {
  final locationState = ref.watch(userLocationProvider);

  if (locationState.status != LocationStatus.granted ||
      locationState.position == null) {
    return [];
  }

  final repository = ref.watch(stopsRepositoryProvider);
  return repository.getStopsNear(
    locationState.position!.latitude,
    locationState.position!.longitude,
    2.0, // 2km radius
  );
}
