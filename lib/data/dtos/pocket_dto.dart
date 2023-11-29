import 'package:lvault/domain/entities/pocket.dart';
import 'package:lvault/utils/type_helpers.dart';

final class PocketDTO {
  final String id;
  final String name;
  final double balance;
  final int createdAt;

  const PocketDTO({
    required this.id,
    required this.name,
    required this.balance,
    required this.createdAt,
  });

  PocketDTO.fromMap(Map<String, Object?> map)
      : id = map['id']!.cast(),
        name = map['name']!.cast(),
        balance = map['balance']!.cast(),
        createdAt = map['created_at']!.cast();

  static List<PocketDTO> listFromMaps(List<Map<String, Object?>> maps) =>
      maps.map((e) => PocketDTO.fromMap(e)).toList();

  Map<String, Object> toMap() => {
        'id': id,
        'name': name,
        'balance': balance,
        'created_at': createdAt,
      };

  Pocket toEntity() => Pocket(
        id: id,
        name: name,
        balance: balance,
        createdAt: createdAt,
      );

  static const String tableName = 'pockets';

  static const String createTable = '''
    CREATE TABLE $tableName (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      balance REAL NOT NULL,
      created_at INTEGER NOT NULL
    )
  ''';
}
