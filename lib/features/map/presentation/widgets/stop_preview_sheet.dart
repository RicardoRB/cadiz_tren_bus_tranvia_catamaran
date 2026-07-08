import 'package:flutter/material.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import 'package:go_router/go_router.dart';

class StopPreviewSheet extends StatelessWidget {
  final StopModel stop;

  const StopPreviewSheet({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    final color = TransportModeColors.getModeColor(stop.transportMode);
    final icon = TransportModeColors.getModeIcon(stop.transportMode);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stop.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      TransportModeColors.getModeName(
                        context,
                        stop.transportMode,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
                context.push('/stops/${stop.id}');
              },
              icon: const Icon(Icons.info_outline),
              label: Text(AppLocalizations.of(context)!.viewFullDetail),
              style: FilledButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
