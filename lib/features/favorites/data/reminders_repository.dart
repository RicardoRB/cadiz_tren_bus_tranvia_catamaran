import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/theme/theme_provider.dart';

part 'reminders_repository.g.dart';

class ReminderModel {
  final String id; // usually stopId_tripId
  final String stopId;
  final String tripId;
  final String stopName;
  final String routeName;
  final String arrivalTime;
  final int minutesBefore;
  final int notificationId;

  ReminderModel({
    required this.id,
    required this.stopId,
    required this.tripId,
    required this.stopName,
    required this.routeName,
    required this.arrivalTime,
    required this.minutesBefore,
    required this.notificationId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'stopId': stopId,
        'tripId': tripId,
        'stopName': stopName,
        'routeName': routeName,
        'arrivalTime': arrivalTime,
        'minutesBefore': minutesBefore,
        'notificationId': notificationId,
      };

  factory ReminderModel.fromJson(Map<String, dynamic> json) => ReminderModel(
        id: json['id'],
        stopId: json['stopId'],
        tripId: json['tripId'],
        stopName: json['stopName'],
        routeName: json['routeName'],
        arrivalTime: json['arrivalTime'],
        minutesBefore: json['minutesBefore'],
        notificationId: json['notificationId'],
      );
}

@riverpod
class Reminders extends _$Reminders {
  static const _remindersKey = 'reminders';

  @override
  Map<String, ReminderModel> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final remindersJson = prefs.getStringList(_remindersKey);
    if (remindersJson == null) return {};

    final Map<String, ReminderModel> reminders = {};
    for (final jsonStr in remindersJson) {
      final model = ReminderModel.fromJson(json.decode(jsonStr));
      reminders[model.id] = model;
    }
    return reminders;
  }

  Future<void> addReminder(ReminderModel reminder) async {
    final newState = Map<String, ReminderModel>.from(state);
    newState[reminder.id] = reminder;
    state = newState;
    await _save();
  }

  Future<void> removeReminder(String id) async {
    final newState = Map<String, ReminderModel>.from(state);
    newState.remove(id);
    state = newState;
    await _save();
  }

  Future<void> _save() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final list = state.values.map((r) => json.encode(r.toJson())).toList();
    await prefs.setStringList(_remindersKey, list);
  }

  ReminderModel? getReminder(String stopId, String tripId) {
    return state['${stopId}_$tripId'];
  }
}
