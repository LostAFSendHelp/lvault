import 'package:lvault/domain/entities/transaction.dart';
import 'package:lvault/domain/entities/transaction_label.dart';

abstract class TransactionRepoExpected {
  Future<List<Transaction>> getAll();

  Future<List<Transaction>> findByPocketId(String pocketId);

  Future<List<Transaction>> findBy({String? pocketId, int? from, int? to});

  Future<Transaction> create({
    required String pocketId,
    required double amount,
    String? notes,
    List<TransactionLabel> labels = const [],
    required int timestamp,
  });

  Future<void> update({required Transaction transaction});

  Future<void> delete({required List<String> transactionIds});
}
