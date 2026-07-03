// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserLocation)
final userLocationProvider = UserLocationProvider._();

final class UserLocationProvider
    extends $NotifierProvider<UserLocation, UserLocationState> {
  UserLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLocationHash();

  @$internal
  @override
  UserLocation create() => UserLocation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserLocationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserLocationState>(value),
    );
  }
}

String _$userLocationHash() => r'4c6c84e8fe4b460f4263532f43ad718b7821887c';

abstract class _$UserLocation extends $Notifier<UserLocationState> {
  UserLocationState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UserLocationState, UserLocationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserLocationState, UserLocationState>,
              UserLocationState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
