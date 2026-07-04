import 'package:flutter/material.dart';

class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LocationPermissionDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue),
          SizedBox(width: 8),
          Text('Ubicación necesaria'),
        ],
      ),
      content: const Text(
        'Para mostrarte las paradas y líneas más cercanas a tu posición, necesitamos acceso a tu ubicación GPS.\n\n'
        'Tus datos de ubicación no se guardan ni se envían a ningún servidor externo.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('AHORA NO'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: const Text('PERMITIR'),
        ),
      ],
    );
  }
}
