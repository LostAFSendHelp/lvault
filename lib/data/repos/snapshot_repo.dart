import 'package:get/get.dart';
import 'package:lvault/data/datasources/local/database_service.dart';
import 'package:lvault/data/dtos/dto_export.dart';
import 'package:lvault/domain/entities/snapshot.dart';
import 'package:lvault/domain/repo-expected/snapshot_repo_expected.dart';

class SnapshotRepo implements SnapshotRepoExpected {
  final DatabaseService _dbService = Get.find();

  @override
  Future<List<Snapshot>> findBy({String? pocketId, int? from, int? to}) async {
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
      SnapshotDTO.tableName,
      where: queryMap.keys.join(' AND '),
      whereArgs: queryMap.values.toList(),
    );

    final dtos = SnapshotDTO.listFromMaps(maps);
    return dtos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Snapshot>> findByPocketId(String pocketId) async {
    final maps = await _dbService.db.query(
      SnapshotDTO.tableName,
      where: 'id = ?',
      whereArgs: [pocketId],
    );

    final dtos = SnapshotDTO.listFromMaps(maps);
    return dtos.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Snapshot>> getAll() async {
    final maps = await _dbService.db.query(SnapshotDTO.tableName);
    final dtos = SnapshotDTO.listFromMaps(maps);
    return dtos.map((e) => e.toEntity()).toList();
  }
}
