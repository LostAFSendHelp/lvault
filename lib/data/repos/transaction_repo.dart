import 'package:get/get.dart';
import 'package:lvault/data/datasources/local/database_service.dart';
import 'package:lvault/data/dtos/transaction_dto.dart';
import 'package:lvault/domain/entities/transaction.dart';
import 'package:lvault/domain/repo-expected/transaction_label_repo_expected.dart';
import 'package:lvault/domain/repo-expected/transaction_repo_expected.dart';

class TransactionRepo implements TransactionRepoExpected {
  final DatabaseService _dbService = Get.find();
  final TransactionLabelRepoExpected _txnLabelRepo = Get.find();

  @override
  Future<List<Transaction>> findBy({
    String? pocketId,
    int? from,
    int? to,
  }) async {
    const idQuery = 'id = ?';
    const fromQuery = 'from <= ?';
    const toQuery = 'to > ?';

    final queryMap = <String, Object?>{
      idQuery: pocketId,
      fromQuery: from,
      toQuery: to,
    };

    queryMap.removeWhere((key, value) => value == null);

    final maps = await _dbService.db.query(
      TransactionDTO.tableName,
      where: queryMap.keys.join(' AND '),
      whereArgs: queryMap.values.toList(),
    );

    final dtos = TransactionDTO.listFromMaps(maps);
    return _createEntities(fromDtos: dtos);
  }

  @override
  Future<List<Transaction>> findByPocketId(String pocketId) async {
    final maps = await _dbService.db.query(
      TransactionDTO.tableName,
      where: 'pocket_id = ?',
      whereArgs: [pocketId],
    );

    final dtos = TransactionDTO.listFromMaps(maps);
    return _createEntities(fromDtos: dtos);
  }

  @override
  Future<List<Transaction>> getAll() async {
    final maps = await _dbService.db.query(
      TransactionDTO.tableName,
    );

    final dtos = TransactionDTO.listFromMaps(maps);
    return _createEntities(fromDtos: dtos);
  }

  Future<List<Transaction>> _createEntities({
    required List<TransactionDTO> fromDtos,
  }) async {
    final labels = await _txnLabelRepo.getAll();

    return fromDtos
        .map(
          (txnDto) => txnDto.createEntity(
            withLabels: labels.where(
              (label) => txnDto.labelIds.contains(label.id),
            ),
          ),
        )
        .toList();
  }
}
