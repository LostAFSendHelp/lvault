import 'package:lvault/domain/entities/transaction.dart';
import 'package:lvault/domain/repo-expected/transaction_repo_expected.dart';

class UCGetTransactionsByDate {
  final TransactionRepoExpected _repo;

  const UCGetTransactionsByDate({required TransactionRepoExpected repo})
      : _repo = repo;

  Future<List<Transaction>> call({int? from, int? to}) {
    return _repo.findBy(from: from, to: to);
  }
}
