import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/models/enums.dart';
import '../providers/lines_list_provider.dart';
import '../../../../core/theme/transport_mode_colors.dart';

class LinesListScreen extends ConsumerStatefulWidget {
  final TransportMode mode;

  const LinesListScreen({super.key, required this.mode});

  @override
  ConsumerState<LinesListScreen> createState() => _LinesListScreenState();
}

class _LinesListScreenState extends ConsumerState<LinesListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedOperatorId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRoutesAsync = ref.watch(filteredRoutesProvider(
      widget.mode,
      searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
      operatorId: _selectedOperatorId,
    ));

    final operatorsAsync = ref.watch(modeOperatorsProvider(widget.mode));

    return Scaffold(
      appBar: AppBar(
        title: Text('Líneas de ${TransportModeColors.getModeName(widget.mode)}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar línea...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          operatorsAsync.when(
            data: (operators) {
              if (operators.length <= 1) return const SizedBox.shrink();
              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: operators.length + 1,
                  itemBuilder: (context, index) {
                    final isAll = index == 0;
                    final opId = isAll ? null : operators[index - 1];
                    final isSelected = _selectedOperatorId == opId;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(isAll ? 'Todos' : opId!),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedOperatorId = selected ? opId : null;
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (err, stack) => const SizedBox.shrink(),
          ),
          Expanded(
            child: filteredRoutesAsync.when(
              data: (routes) {
                if (routes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 48, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(_searchQuery.isEmpty
                            ? 'No hay líneas disponibles'
                            : 'No se encontraron líneas para "$_searchQuery"'),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: routes.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final route = routes[index];
                    final color = route.colorHex != null
                        ? Color(int.parse('FF${route.colorHex!.replaceFirst('#', '')}', radix: 16))
                        : TransportModeColors.getModeColor(widget.mode);

                    return ListTile(
                      leading: Container(
                        width: 12,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      title: Text(
                        route.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Operador: ${route.operatorId}'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/lines/detail/${route.id}'),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
