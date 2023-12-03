import 'package:lvault/domain/entities/pocket.dart';
import 'package:lvault/domain/repo-expected/pocket_repo_expected.dart';

class UCCreatePocket {
  final PocketRepoExpected _repo;

  const UCCreatePocket({required PocketRepoExpected repo}) : _repo = repo;

  Future<Pocket> call({required String name}) {
    return _repo.create(name: name);
  }
}
