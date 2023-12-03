import 'package:lvault/data/repos/pocket_repo.dart';
import 'package:lvault/domain/repo-expected/pocket_repo_expected.dart';
import 'package:lvault/domain/usecases/pocket/uc_create_pocket.dart';
import 'package:lvault/domain/usecases/pocket/uc_get_all_pockets.dart';

class PocketUsecaseProvider {
  final PocketRepoExpected _repo;

  const PocketUsecaseProvider({required PocketRepoExpected repo})
      : _repo = repo;

  static PocketUsecaseProvider instance =
      PocketUsecaseProvider(repo: PocketRepo());

  UCGetAllPockets getAllPockets() {
    return UCGetAllPockets(repo: _repo);
  }

  UCCreatePocket createPocket() {
    return UCCreatePocket(repo: _repo);
  }
}
