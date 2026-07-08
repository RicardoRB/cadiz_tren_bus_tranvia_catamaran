import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LocationPermissionDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.blue),
          const SizedBox(width: 8),
          Text(l10n.locationPermissionTitle),
        ],
      ),
      content: Text(l10n.locationPermissionContent),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.notNow),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(l10n.allow),
        ),
      ],
    );
  }
}
