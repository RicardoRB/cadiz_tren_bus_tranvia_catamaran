import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/models/enums.dart';
import '../providers/lines_list_provider.dart';
import '../../../../core/theme/transport_mode_colors.dart';
import '../../../../shared/widgets/loading_shimmer.dart';

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
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = query;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredRoutesAsync = ref.watch(
      filteredRoutesProvider(
        widget.mode,
        searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
        operatorId: _selectedOperatorId,
      ),
    );

    final operatorsAsync = ref.watch(modeOperatorsProvider(widget.mode));
    final operatorsMapAsync = ref.watch(operatorsMapProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.linesOf(
            TransportModeColors.getModeName(context, widget.mode),
          ),
        ),
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
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          operatorsAsync.when(
            data: (operators) {
              if (operators.length <= 1) return const SizedBox.shrink();
              final operatorsMap = operatorsMapAsync.value ?? {};

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
                    final opName = isAll
                        ? 'Todos'
                        : (operatorsMap[opId] ?? opId);

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(opName!),
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
                        const Icon(
                          Icons.search_off,
                          size: 48,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchQuery.isEmpty
                              ? 'No hay líneas disponibles'
                              : 'No se encontraron líneas para "$_searchQuery"',
                        ),
                      ],
                    ),
                  );
                }
                final operatorsMap = operatorsMapAsync.value ?? {};

                return ListView.separated(
                  itemCount: routes.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final route = routes[index];
                    final color = TransportModeColors.parseHex(
                      route.colorHex,
                      widget.mode,
                    );
                    final opName =
                        operatorsMap[route.operatorId] ?? route.operatorId;

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
                      subtitle: Text('Operador: $opName'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/lines/${route.id}'),
                    );
                  },
                );
              },
              loading: () => const LoadingShimmer(child: ListLoadingShimmer()),
        error: (err, stack) => Center(
          child: Text(AppLocalizations.of(context)!.errorWithDetail(err.toString())),
        ),
            ),
          ),
        ],
      ),
    );
  }
}
