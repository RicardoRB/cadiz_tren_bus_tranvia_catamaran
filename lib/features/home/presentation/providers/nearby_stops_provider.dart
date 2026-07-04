import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../map/presentation/providers/user_location_provider.dart';
import '../data/nearby_stops_repository.dart';
import '../domain/nearby_stop_model.dart';
import '../../../../database/drift/database_provider.dart';

final nearbyStopsRepoProvider = Provider<NearbyStopsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return NearbyStopsRepository(db);
});

class NearbyStopsNotifier
    extends AutoDisposeAsyncNotifier<List<NearbyStopModel>> {
  Timer? _timer;
  double _radius = 1.0;

  @override
  Future<List<NearbyStopModel>> build() async {
    ref.onDispose(() => _timer?.cancel());

    if (_timer == null) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        ref.invalidateSelf();
      });
    }

    final locationState = ref.watch(userLocationProvider);

    if (locationState.status != LocationStatus.granted ||
        locationState.position == null) {
      return [];
    }

    final repository = ref.watch(nearbyStopsRepoProvider);
    return repository.getNearbyStopsWithNextDeparture(
      lat: locationState.position!.latitude,
      lon: locationState.position!.longitude,
      radiusInKm: _radius,
      now: DateTime.now(),
    );
  }

  void setRadius(double newRadius) {
    _radius = newRadius;
    ref.invalidateSelf();
  }

  double get currentRadius => _radius;
}

final nearbyStopsWithNextDepartureProvider =
    AsyncNotifierProvider.autoDispose<
      NearbyStopsNotifier,
      List<NearbyStopModel>
    >(() {
      return NearbyStopsNotifier();
    });
