import 'package:lvault/domain/entities/transaction_label.dart';

final class Transaction {
  final String id;
  final double amount;
  final String pocketId;
  final String? notes;
  final List<TransactionLabel> labels;
  final int timestamp;

  const Transaction({
    required this.id,
    required this.amount,
    required this.pocketId,
    this.notes,
    required this.labels,
    required this.timestamp,
  });
}
