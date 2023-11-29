import 'package:lvault/domain/entities/transaction.dart';
import 'package:lvault/domain/entities/transaction_label.dart';
import 'package:lvault/utils/type_helpers.dart';

class TransactionDTO {
  final String id;
  final double amount;
  final String pocketId;
  final String? notes;
  final List<String> labelIds;
  final int timestamp;

  const TransactionDTO({
    required this.id,
    required this.amount,
    required this.pocketId,
    this.notes,
    this.labelIds = const [],
    required this.timestamp,
  });

  TransactionDTO.fromMap(Map<String, Object?> map)
      : id = map['id']!.cast(),
        amount = map['amount']!.cast(),
        pocketId = map['pocket_id']!.cast(),
        notes = map['notes']!.cast(),
        labelIds = map['label_ids']!.castOr('').split(', '),
        timestamp = map['timestamp']!.cast();

  static List<TransactionDTO> listFromMaps(List<Map<String, Object?>> maps) =>
      maps.map((e) => TransactionDTO.fromMap(e)).toList();

  Map<String, Object?> toMap() => {
        'id': id,
        'amount': amount,
        'pocket_id': pocketId,
        'notes': notes,
        'label_ids': labelIds.join(', '),
        'timestamp': timestamp,
      };

  Transaction createEntity({required Iterable<TransactionLabel> withLabels}) =>
      Transaction(
        id: id,
        amount: amount,
        pocketId: pocketId,
        labels: withLabels.toList(),
        timestamp: timestamp,
      );

  static const String tableName = 'transactions';

  static const String createTable = '''
    CREATE TABLE $tableName (
      id TEXT PRIMARY KEY,
      amount REAL NOT NULL,
      pocket_id TEXT NOT NULL,
      notes TEXT,
      timestamp INTEGER NOT NULL,
      FOREIGN KEY(pocket_id) REFERENCES pockets(id) ON DELETE CASCADE
    )
  ''';
}
