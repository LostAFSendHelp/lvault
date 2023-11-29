import 'package:get/get.dart';
import 'package:lvault/data/datasources/local/database_service.dart';
import 'package:lvault/data/dtos/pocket_dto.dart';
import 'package:lvault/domain/entities/pocket.dart';
import 'package:lvault/domain/repo-expected/pocket_repo_expected.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class PocketRepo implements PocketRepoExpected {
  final DatabaseService _dbService = Get.find();
  final Uuid _uuid = const Uuid();

  @override
  Future<List<Pocket>> getAll() async {
    final maps = await _dbService.db.query(PocketDTO.tableName);
    final dtos = PocketDTO.listFromMaps(maps);
    final entities = dtos.map((e) => e.toEntity()).toList();
    return entities;
  }

  @override
  Future<Pocket> create({required String name, required double balance}) async {
    final dto = PocketDTO(
      id: _uuid.v1(),
      name: name,
      balance: balance,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    await _dbService.db.insert(
      PocketDTO.tableName,
      dto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );

    return dto.toEntity();
  }

  @override
  Future<void> delete({required String pocketId}) async {
    await _dbService.db.delete(
      PocketDTO.tableName,
      where: 'id = ?',
      whereArgs: [pocketId],
    );
  }

  @override
  Future<void> update({required Pocket pocket}) async {
    await _dbService.db.update(
      PocketDTO.tableName,
      {'name': pocket.name, 'balance': pocket.balance},
      where: 'id = ?',
      whereArgs: [pocket.id],
    );
  }
}
