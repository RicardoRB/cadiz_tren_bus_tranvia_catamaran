import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../database/drift/database_provider.dart';
import '../../data/routes_repository.dart';

part 'routes_provider.g.dart';

@Riverpod(keepAlive: true)
RoutesRepository routesRepository(RoutesRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return RoutesRepository(db.routesDao);
}
