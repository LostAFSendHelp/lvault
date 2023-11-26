import 'package:get/get.dart';
import 'package:lvault/data/datasources/local/database_service.dart';
import 'package:lvault/data/dtos/transaction_label_dto.dart';
import 'package:lvault/domain/entities/transaction_label.dart';
import 'package:lvault/domain/repo-expected/transaction_label_repo_expected.dart';

class TransactionLabelRepo implements TransactionLabelRepoExpected {
  final DatabaseService _dbService = Get.find();

  /// Local cache to minimize direct reads
  List<TransactionLabelDTO> _dtos = [];

  var _didGetAll = false;

  @override
  Future<List<TransactionLabel>> getAll() async {
    if (_didGetAll) return _dtos.map((e) => e.toEntity()).toList();

    final maps = await _dbService.db.query(TransactionLabelDTO.tableName);
    _dtos = TransactionLabelDTO.listFromMaps(maps);
    _didGetAll = true;

    return _dtos.map((e) => e.toEntity()).toList();
  }
}
