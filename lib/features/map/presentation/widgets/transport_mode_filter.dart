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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: TransportMode.values.map((mode) {
          final isSelected = selectedModes.contains(mode);
          final color = TransportModeColors.getModeColor(mode);

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              label: Text(TransportModeColors.getModeName(mode)),
              selected: isSelected,
              onSelected: (selected) {
                final newSelection = Set<TransportMode>.from(selectedModes);
                if (selected) {
                  newSelection.add(mode);
                } else {
                  if (newSelection.length > 1) {
                    newSelection.remove(mode);
                  }
                }
                onChanged(newSelection);
              },
              selectedColor: color.withValues(alpha: 0.2),
              checkmarkColor: color,
              labelStyle: TextStyle(
                color: isSelected ? color : null,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
              avatar: Icon(
                TransportModeColors.getModeIcon(mode),
                size: 18,
                color: isSelected ? color : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
