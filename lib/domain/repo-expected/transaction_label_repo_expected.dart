import 'package:lvault/domain/entities/transaction_label.dart';

abstract class TransactionLabelRepoExpected {
  Future<List<TransactionLabel>> getAll();

  Future<TransactionLabel> create({
    required String name,
    required String colorCode,
  });

  Future<void> update({required TransactionLabel transactionLabel});

  Future<void> delete({required String id});
}
