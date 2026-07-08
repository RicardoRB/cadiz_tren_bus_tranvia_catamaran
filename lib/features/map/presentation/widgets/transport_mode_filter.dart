import 'package:flutter/material.dart';
import '../../../../shared/models/enums.dart';
import '../../../../core/theme/transport_mode_colors.dart';

class TransportModeFilter extends StatelessWidget {
  final Set<TransportMode> selectedModes;
  final ValueChanged<Set<TransportMode>> onChanged;

  const TransportModeFilter({
    super.key,
    required this.selectedModes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TransportMode>(
      icon: const Icon(Icons.filter_list),
      tooltip: 'Filtrar modos de transporte',
      onSelected: (mode) {
        final newSelection = Set<TransportMode>.from(selectedModes);
        if (newSelection.contains(mode)) {
          if (newSelection.length > 1) {
            newSelection.remove(mode);
          }
        } else {
          newSelection.add(mode);
        }
        onChanged(newSelection);
      },
      itemBuilder: (context) {
        return TransportMode.values.map((mode) {
          final isSelected = selectedModes.contains(mode);
          final color = TransportModeColors.getModeColor(mode);

          return CheckedPopupMenuItem<TransportMode>(
            value: mode,
            checked: isSelected,
            child: Row(
              children: [
                Icon(
                  TransportModeColors.getModeIcon(mode),
                  size: 20,
                  color: color,
                ),
                const SizedBox(width: 12),
                Text(TransportModeColors.getModeName(context, mode)),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
