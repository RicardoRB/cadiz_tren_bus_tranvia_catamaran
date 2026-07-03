import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'stops_provider.dart';
import '../../../../shared/models/domain/stop.dart';

part 'stop_detail_provider.g.dart';

@riverpod
Future<StopModel?> stopDetail(Ref ref, String id) {
  return ref.watch(stopsRepositoryProvider).getStopById(id);
}
