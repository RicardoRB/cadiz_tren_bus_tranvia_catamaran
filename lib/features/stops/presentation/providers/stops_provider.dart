import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../database/drift/database_provider.dart';
import '../../../../shared/models/domain/stop.dart';
import '../../data/stops_repository.dart';

part 'stops_provider.g.dart';

@Riverpod(keepAlive: true)
StopsRepository stopsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return StopsRepository(db.stopsDao);
}

@riverpod
Future<List<StopModel>> allStops(Ref ref) {
  return ref.watch(stopsRepositoryProvider).getAllStops();
}
