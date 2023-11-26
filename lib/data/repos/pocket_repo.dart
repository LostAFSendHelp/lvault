import 'package:get/get.dart';
import 'package:lvault/data/datasources/local/database_service.dart';
import 'package:lvault/data/dtos/pocket_dto.dart';
import 'package:lvault/domain/entities/Pocket.dart';
import 'package:lvault/domain/repo-expected/pocket_repo_expected.dart';

class PocketRepo implements PocketRepoExpected {
  final DatabaseService _dbService = Get.find();

  @override
  Future<List<Pocket>> getAll() async {
    final maps = await _dbService.db.query(PocketDTO.tableName);
    final dtos = PocketDTO.listFromMaps(maps);
    final entities = dtos.map((e) => e.toEntity());
    return List.from(entities);
  }
}
