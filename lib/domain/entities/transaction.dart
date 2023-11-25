import 'package:lvault/domain/entities/transaction_label.dart';

final class Transaction {
  final String id;
  final int amount;
  final String pocketId;
  final List<TransactionLabel> labels;
  final int timestamp;

  const Transaction({
    required this.id,
    required this.amount,
    required this.pocketId,
    required this.labels,
    required this.timestamp,
  });
}
