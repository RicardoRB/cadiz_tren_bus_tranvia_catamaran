import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../database/drift/database_provider.dart';
import '../../data/routes_repository.dart';
import '../../data/operators_repository.dart';

part 'routes_provider.g.dart';

@Riverpod(keepAlive: true)
RoutesRepository routesRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return RoutesRepository(db.routesDao);
}

@Riverpod(keepAlive: true)
OperatorsRepository operatorsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return OperatorsRepository(db.operatorsDao);
}
