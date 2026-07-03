import '../../../database/drift/daos/operators_dao.dart';
import '../../../shared/models/domain/operator.dart';

class OperatorsRepository {
  final OperatorsDao _operatorsDao;

  OperatorsRepository(this._operatorsDao);

  Future<List<OperatorModel>> getAllOperators() async {
    final operators = await _operatorsDao.getAllOperators();
    return operators.map((o) => OperatorModel(
      id: o.id,
      name: o.name,
      transportMode: o.transportMode,
      attributionText: o.attributionText,
      licenseUrl: o.licenseUrl,
    )).toList();
  }

  Future<OperatorModel?> getOperatorById(String id) async {
    final operator = await _operatorsDao.getOperatorById(id);
    return operator != null ? OperatorModel(
      id: operator.id,
      name: operator.name,
      transportMode: operator.transportMode,
      attributionText: operator.attributionText,
      licenseUrl: operator.licenseUrl,
    ) : null;
  }
}
