import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../database/drift/database_provider.dart';
import '../../data/search_repository.dart';
import '../../../../shared/models/domain/route.dart';
import '../../../../shared/models/domain/stop.dart';

part 'search_provider.g.dart';

@Riverpod(keepAlive: true)
SearchRepository searchRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SearchRepository(db);
}

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

@riverpod
Future<String> debouncedSearchQuery(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  await Future.delayed(const Duration(milliseconds: 300));
  return query;
}

class SearchResult {
  final List<RouteModel> routes;
  final List<StopModel> stops;

  const SearchResult({required this.routes, required this.stops});
}

@riverpod
Future<SearchResult> searchResults(Ref ref) async {
  final query = await ref.watch(debouncedSearchQueryProvider.future);
  if (query.isEmpty || query.length < 2) {
    return const SearchResult(routes: [], stops: []);
  }

  final repository = ref.watch(searchRepositoryProvider);
  final routes = await repository.searchRoutes(query);
  final stops = await repository.searchStops(query);

  return SearchResult(routes: routes, stops: stops);
}
