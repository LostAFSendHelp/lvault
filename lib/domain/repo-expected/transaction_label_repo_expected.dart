import 'package:lvault/domain/entities/transaction_label.dart';

abstract class TransactionLabelRepoExpected {
  Future<List<TransactionLabel>> getAll();
}
