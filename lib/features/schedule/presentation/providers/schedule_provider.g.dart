// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scheduleRepository)
final scheduleRepositoryProvider = ScheduleRepositoryProvider._();

final class ScheduleRepositoryProvider
    extends
        $FunctionalProvider<
          ScheduleRepository,
          ScheduleRepository,
          ScheduleRepository
        >
    with $Provider<ScheduleRepository> {
  ScheduleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleRepositoryHash();

  @$internal
  @override
  $ProviderElement<ScheduleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScheduleRepository create(Ref ref) {
    return scheduleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScheduleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScheduleRepository>(value),
    );
  }
}

String _$scheduleRepositoryHash() =>
    r'018d30afdb4dfb1abe3afc5c9df0b537238d452a';

@ProviderFor(stopSchedule)
final stopScheduleProvider = StopScheduleFamily._();

final class StopScheduleProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StopTimeModel>>,
          List<StopTimeModel>,
          FutureOr<List<StopTimeModel>>
        >
    with
        $FutureModifier<List<StopTimeModel>>,
        $FutureProvider<List<StopTimeModel>> {
  StopScheduleProvider._({
    required StopScheduleFamily super.from,
    required (String, DayType) super.argument,
  }) : super(
         retry: null,
         name: r'stopScheduleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stopScheduleHash();

  @override
  String toString() {
    return r'stopScheduleProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<StopTimeModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StopTimeModel>> create(Ref ref) {
    final argument = this.argument as (String, DayType);
    return stopSchedule(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is StopScheduleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stopScheduleHash() => r'e1fc8e83c892cf56f287a05920c3d1a487ad05d8';

final class StopScheduleFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<StopTimeModel>>,
          (String, DayType)
        > {
  StopScheduleFamily._()
    : super(
        retry: null,
        name: r'stopScheduleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StopScheduleProvider call(String stopId, DayType dayType) =>
      StopScheduleProvider._(argument: (stopId, dayType), from: this);

  @override
  String toString() => r'stopScheduleProvider';
}

@ProviderFor(upcomingStopTimes)
final upcomingStopTimesProvider = UpcomingStopTimesFamily._();

final class UpcomingStopTimesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StopTimeModel>>,
          List<StopTimeModel>,
          FutureOr<List<StopTimeModel>>
        >
    with
        $FutureModifier<List<StopTimeModel>>,
        $FutureProvider<List<StopTimeModel>> {
  UpcomingStopTimesProvider._({
    required UpcomingStopTimesFamily super.from,
    required (String, DateTime, {int? limit}) super.argument,
  }) : super(
         retry: null,
         name: r'upcomingStopTimesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$upcomingStopTimesHash();

  @override
  String toString() {
    return r'upcomingStopTimesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<StopTimeModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StopTimeModel>> create(Ref ref) {
    final argument = this.argument as (String, DateTime, {int? limit});
    return upcomingStopTimes(
      ref,
      argument.$1,
      argument.$2,
      limit: argument.limit,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UpcomingStopTimesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upcomingStopTimesHash() => r'e7e11ff0394efab27cf0f9bf086dabbb2fcb8a88';

final class UpcomingStopTimesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<StopTimeModel>>,
          (String, DateTime, {int? limit})
        > {
  UpcomingStopTimesFamily._()
    : super(
        retry: null,
        name: r'upcomingStopTimesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpcomingStopTimesProvider call(String stopId, DateTime now, {int? limit}) =>
      UpcomingStopTimesProvider._(
        argument: (stopId, now, limit: limit),
        from: this,
      );

  @override
  String toString() => r'upcomingStopTimesProvider';
}
