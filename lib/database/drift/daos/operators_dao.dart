import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/operators_table.dart';

part 'operators_dao.g.dart';

@DriftAccessor(tables: [Operators])
class OperatorsDao extends DatabaseAccessor<AppDatabase> with _$OperatorsDaoMixin {
  OperatorsDao(super.db);

  Future<List<Operator>> getAllOperators() => select(operators).get();
  Future<Operator?> getOperatorById(String id) => (select(operators)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<int> insertOperator(Operator op) => into(operators).insert(op, mode: InsertMode.insertOrReplace);
}
