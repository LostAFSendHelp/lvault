import 'package:lvault/domain/entities/transaction.dart';
import 'package:lvault/domain/entities/snapshot.dart';

final class Pocket {
  final String id;
  final String name;
  final int balance;
  final List<Transaction> transactions;
  final List<Snapshot> snapshots;

  const Pocket({
    required this.id,
    required this.name,
    required this.balance,
    required this.transactions,
    required this.snapshots,
  });
}
