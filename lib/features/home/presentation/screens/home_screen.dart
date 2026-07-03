import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../../../../shared/models/enums.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CadizTransit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
            tooltip: 'Buscar',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: 'Ajustes',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modos de Transporte',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _TransportModeCard(mode: TransportMode.bus),
                _TransportModeCard(mode: TransportMode.tram),
                _TransportModeCard(mode: TransportMode.commuterRail),
                _TransportModeCard(mode: TransportMode.catamaran),
              ],
            ),
            const SizedBox(height: 32),
            Text('Favoritos', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    'Aún no tienes favoritos',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransportModeCard extends StatelessWidget {
  final TransportMode mode;

  const _TransportModeCard({required this.mode});

  @override
  Widget build(BuildContext context) {
    final color = TransportModeColors.getModeColor(mode);
    final icon = TransportModeColors.getModeIcon(mode);
    final name = TransportModeColors.getModeName(mode);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/lines/${mode.name}'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
