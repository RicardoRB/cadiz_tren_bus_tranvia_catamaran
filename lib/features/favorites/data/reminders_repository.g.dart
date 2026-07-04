// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Reminders)
final remindersProvider = RemindersProvider._();

final class RemindersProvider
    extends $NotifierProvider<Reminders, Map<String, ReminderModel>> {
  RemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remindersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remindersHash();

  @$internal
  @override
  Reminders create() => Reminders();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, ReminderModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, ReminderModel>>(value),
    );
  }
}

String _$remindersHash() => r'fc85b78da166acfb828e67614295ecfc718f9f06';

abstract class _$Reminders extends $Notifier<Map<String, ReminderModel>> {
  Map<String, ReminderModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<Map<String, ReminderModel>, Map<String, ReminderModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, ReminderModel>,
                Map<String, ReminderModel>
              >,
              Map<String, ReminderModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
