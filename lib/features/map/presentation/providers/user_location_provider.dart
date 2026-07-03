import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'user_location_provider.g.dart';

enum LocationStatus {
  initial,
  loading,
  granted,
  denied,
  permanentlyDenied,
  disabled,
  error,
}

class UserLocationState {
  final LocationStatus status;
  final Position? position;
  final String? errorMessage;

  UserLocationState({required this.status, this.position, this.errorMessage});

  UserLocationState copyWith({
    LocationStatus? status,
    Position? position,
    String? errorMessage,
  }) {
    return UserLocationState(
      status: status ?? this.status,
      position: position ?? this.position,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class UserLocation extends _$UserLocation {
  @override
  UserLocationState build() {
    return UserLocationState(status: LocationStatus.initial);
  }

  Future<void> updateLocation({bool requestPermission = false}) async {
    state = state.copyWith(status: LocationStatus.loading);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(status: LocationStatus.disabled);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied && requestPermission) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        state = state.copyWith(status: LocationStatus.denied);
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(status: LocationStatus.permanentlyDenied);
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      state = UserLocationState(
        status: LocationStatus.granted,
        position: position,
      );
    } catch (e) {
      state = UserLocationState(
        status: LocationStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> openSettings() async {
    await Geolocator.openAppSettings();
  }
}
