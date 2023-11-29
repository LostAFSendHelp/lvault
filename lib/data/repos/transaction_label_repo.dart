import 'package:get/get.dart';
import 'package:lvault/data/datasources/local/database_service.dart';
import 'package:lvault/data/dtos/transaction_label_dto.dart';
import 'package:lvault/domain/entities/transaction_label.dart';
import 'package:lvault/domain/repo-expected/transaction_label_repo_expected.dart';
import 'package:uuid/uuid.dart';

class TransactionLabelRepo implements TransactionLabelRepoExpected {
  final DatabaseService _dbService = Get.find();
  final Uuid _uuid = const Uuid();

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

  @override
  Future<TransactionLabel> create({
    required String name,
    required String colorCode,
  }) async {
    final dto = TransactionLabelDTO(
      id: _uuid.v1(),
      name: name,
      colorCode: colorCode,
    );

    await _dbService.db.insert(TransactionLabelDTO.tableName, dto.toMap());
    _dtos.add(dto);
    return dto.toEntity();
  }

  @override
  Future<void> delete({required String id}) async {
    await _dbService.db.delete(
      TransactionLabelDTO.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    _dtos.removeWhere((dto) => dto.id == id);
  }

  @override
  Future<void> update({required TransactionLabel transactionLabel}) async {
    await _dbService.db.update(
      TransactionLabelDTO.tableName,
      {'name': transactionLabel.name, 'colorCode': transactionLabel.colorCode},
      where: 'id = ?',
      whereArgs: [transactionLabel.id],
    );

    _dtos.removeWhere((dto) => dto.id == transactionLabel.id);
    _dtos.add(TransactionLabelDTO(
      id: transactionLabel.id,
      name: transactionLabel.name,
      colorCode: transactionLabel.colorCode,
    ));
  }
}
