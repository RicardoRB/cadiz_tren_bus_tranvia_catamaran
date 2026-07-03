import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/enums.dart';
import '../providers/schedule_provider.dart';
import '../../domain/day_type_resolver.dart';
import '../../../../shared/widgets/loading_shimmer.dart';

class ScheduleTable extends ConsumerWidget {
  final String stopId;

  const ScheduleTable({super.key, required this.stopId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      initialIndex: _getInitialTabIndex(),
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Laborable'),
              Tab(text: 'Sábado'),
              Tab(text: 'Festivo'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _ScheduleList(stopId: stopId, dayType: DayType.weekday),
                _ScheduleList(stopId: stopId, dayType: DayType.saturday),
                _ScheduleList(stopId: stopId, dayType: DayType.holiday),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getInitialTabIndex() {
    final dayType = resolveDayType(DateTime.now());
    switch (dayType) {
      case DayType.weekday:
        return 0;
      case DayType.saturday:
        return 1;
      case DayType.holiday:
        return 2;
    }
  }
}

class _ScheduleList extends ConsumerWidget {
  final String stopId;
  final DayType dayType;

  const _ScheduleList({required this.stopId, required this.dayType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(stopScheduleProvider(stopId, dayType));

    return scheduleAsync.when(
      data: (times) {
        if (times.isEmpty) {
          return const Center(
            child: Text('No hay horarios para este tipo de día'),
          );
        }

        // Group by hour
        final grouped = <int, List<String>>{};
        for (final t in times) {
          final parts = t.arrivalTime.split(':');
          final hour = int.parse(parts[0]);
          final minute = parts[1];
          grouped.putIfAbsent(hour, () => []).add(minute);
        }

        final sortedHours = grouped.keys.toList()..sort();

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sortedHours.length,
          itemBuilder: (context, index) {
            final hour = sortedHours[index];
            final minutes = grouped[hour]!;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      hour.toString().padLeft(2, '0'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: minutes.map((m) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(m),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const LoadingShimmer(child: ListLoadingShimmer()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
