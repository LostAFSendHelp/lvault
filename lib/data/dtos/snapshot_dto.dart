import 'package:lvault/domain/entities/snapshot.dart';
import 'package:lvault/utils/type_helpers.dart';

final class SnapshotDTO {
  final String id;
  final String pocketId;
  final double balance;
  final int timestamp;

  const SnapshotDTO({
    required this.id,
    required this.pocketId,
    required this.balance,
    required this.timestamp,
  });

  SnapshotDTO.fromMap(Map<String, Object?> map)
      : id = map['id']!.cast(),
        pocketId = map['pocket_id']!.cast(),
        balance = map['balance']!.cast(),
        timestamp = map['timestamp']!.cast();

  static List<SnapshotDTO> listFromMaps(List<Map<String, Object?>> maps) =>
      maps.map((e) => SnapshotDTO.fromMap(e)).toList();

  Map<String, Object> toMap() => {
        'id': id,
        'pocket_id': pocketId,
        'balance': balance,
        'timestamp': timestamp
      };

  Snapshot toEntity() => Snapshot(
        id: id,
        pocketId: pocketId,
        balance: balance,
        timestamp: timestamp,
      );

  static const String tableName = 'snapshots';

  static const String createTable = '''
    CREATE TABLE $tableName (
      id TEXT PRIMARY KEY,
      pocket_id TEXT NOT NULL,
      balance REAL NOT NULL,
      timestamp INTEGER NOT NULL,
      FOREIGN KEY(pocket_id) REFERENCES pockets(id) ON DELETE CASCADE
    )
  ''';
}
