import 'package:lvault/domain/entities/pocket.dart';
import 'package:lvault/domain/repo-expected/pocket_repo_expected.dart';

class UCGetAllPockets {
  final PocketRepoExpected _repo;

  const UCGetAllPockets({required PocketRepoExpected repo}) : _repo = repo;

  Future<List<Pocket>> call() {
    return _repo.getAll();
  }

  Future<Pocket> create({required String name}) {
    return _repo.create(name: name);
  }
}
