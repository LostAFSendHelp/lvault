import 'package:lvault/domain/entities/transaction.dart';
import 'package:lvault/domain/entities/transaction_label.dart';

abstract class TransactionRepoExpected {
  Future<List<Transaction>> getAll();

  Future<List<Transaction>> findByPocketId(String pocketId);

  Future<List<Transaction>> findBy({
    String? pocketId,
    int? from,
    int? to,
    TransactionLabel? transactionLabel,
  });
}
