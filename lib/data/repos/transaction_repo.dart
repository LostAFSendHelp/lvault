import 'package:get/get.dart';
import 'package:lvault/data/datasources/local/database_service.dart';
import 'package:lvault/data/dtos/transaction_dto.dart';
import 'package:lvault/domain/entities/transaction.dart';
import 'package:lvault/domain/entities/transaction_label.dart';
import 'package:lvault/domain/repo-expected/transaction_label_repo_expected.dart';
import 'package:lvault/domain/repo-expected/transaction_repo_expected.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:uuid/uuid.dart';

class TransactionRepo implements TransactionRepoExpected {
  final DatabaseService _dbService = Get.find();
  final TransactionLabelRepoExpected _txnLabelRepo = Get.find();
  final Uuid _uuid = const Uuid();

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

  @override
  Future<Transaction> create({
    required String pocketId,
    required double amount,
    String? notes,
    List<TransactionLabel> labels = const [],
    required int timestamp,
  }) async {
    final dto = TransactionDTO(
      id: _uuid.v1(),
      amount: amount,
      pocketId: pocketId,
      notes: notes,
      labelIds: (await _verifyLabels(labels)).map((label) => label.id).toList(),
      timestamp: timestamp,
    );

    await _dbService.db.insert(TransactionDTO.tableName, dto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return (await _createEntities(fromDtos: [dto])).first;
  }

  @override
  Future<void> delete({required List<String> transactionIds}) async {
    await _dbService.db.delete(
      TransactionDTO.tableName,
      where: 'id in (${List.filled(transactionIds.length, '?').join(', ')})',
      whereArgs: transactionIds,
    );
  }

  @override
  Future<void> update({required Transaction transaction}) async {
    await _dbService.db.update(TransactionDTO.tableName, {
      'pocket_id': transaction.pocketId,
      'amount': transaction.amount,
      'notes': transaction.notes,
      'transaction_labels': (await _verifyLabels(transaction.labels))
          .map((label) => label.id)
          .join(', '),
      'timestamp': transaction.timestamp,
    });
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

  Future<List<TransactionLabel>> _verifyLabels(
    List<TransactionLabel> labels,
  ) async {
    final availableLabels = await _txnLabelRepo.getAll();

    return labels.where((label) => availableLabels.contains(label)).toList();
  }
}
