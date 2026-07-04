import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/notifications/notification_service.dart';
import '../../../../shared/models/domain/stop_time.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../../favorites/data/reminders_repository.dart';

class ReminderPicker extends ConsumerStatefulWidget {
  final StopModel stop;
  final StopTimeModel stopTime;

  const ReminderPicker({
    super.key,
    required this.stop,
    required this.stopTime,
  });

  @override
  ConsumerState<ReminderPicker> createState() => _ReminderPickerState();
}

class _ReminderPickerState extends ConsumerState<ReminderPicker> {
  int _selectedMinutes = 10;

  @override
  Widget build(BuildContext context) {
    final reminder = ref.watch(remindersProvider)[
      '${widget.stop.id}_${widget.stopTime.tripId}'
    ];

    return AlertDialog(
      title: const Text('Configurar recordatorio'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Parada: ${widget.stop.name}'),
          Text('Hora: ${widget.stopTime.arrivalTime.substring(0, 5)}'),
          const SizedBox(height: 16),
          const Text('Avisarme antes:'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [5, 10, 15, 30].map((mins) {
              return ChoiceChip(
                label: Text('$mins min'),
                selected: _selectedMinutes == mins,
                onSelected: (selected) {
                  if (selected) {
                    setState(() => _selectedMinutes = mins);
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        if (reminder != null)
          TextButton(
            onPressed: () async {
              await ref
                  .read(notificationServiceProvider.notifier)
                  .cancelNotification(reminder.notificationId);
              await ref
                  .read(remindersProvider.notifier)
                  .removeReminder(reminder.id);
              if (context.mounted) Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            final granted = await ref
                .read(notificationServiceProvider.notifier)
                .requestPermissions();

            if (!granted) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Permiso de notificaciones denegado'),
                  ),
                );
              }
              return;
            }

            final now = DateTime.now();
            final timeParts = widget.stopTime.arrivalTime.split(':');
            var scheduledDate = DateTime(
              now.year,
              now.month,
              now.day,
              int.parse(timeParts[0]),
              int.parse(timeParts[1]),
            ).subtract(Duration(minutes: _selectedMinutes));

            // If scheduled time is in the past for today, we could assume next day
            // but for simple zonedSchedule with matchDateTimeComponents: time,
            // it will trigger daily.

            final notificationId =
                '${widget.stop.id}${widget.stopTime.tripId}'.hashCode.abs() %
                100000;

            await ref.read(notificationServiceProvider.notifier).scheduleNotification(
                  id: notificationId,
                  title: '¡Tu transporte se acerca!',
                  body:
                      'La línea en ${widget.stop.name} pasará en $_selectedMinutes minutos (${widget.stopTime.arrivalTime.substring(0, 5)}).',
                  scheduledDate: scheduledDate,
                );

            await ref.read(remindersProvider.notifier).addReminder(
                  ReminderModel(
                    id: '${widget.stop.id}_${widget.stopTime.tripId}',
                    stopId: widget.stop.id,
                    tripId: widget.stopTime.tripId,
                    stopName: widget.stop.name,
                    routeName: '', // Could be fetched if needed
                    arrivalTime: widget.stopTime.arrivalTime,
                    minutesBefore: _selectedMinutes,
                    notificationId: notificationId,
                  ),
                );

            if (context.mounted) Navigator.pop(context);
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
