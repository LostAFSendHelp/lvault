import 'package:lvault/domain/entities/transaction_label.dart';
import 'package:lvault/utils/type_helpers.dart';

class TransactionLabelDTO {
  final String id;
  final String name;
  final String colorCode;

  const TransactionLabelDTO({
    required this.id,
    required this.name,
    required this.colorCode,
  });

  TransactionLabelDTO.fromMap(Map<String, Object?> map)
      : id = map['id']!.cast(),
        name = map['name']!.cast(),
        colorCode = map['colorCode']!.cast();

  static List<TransactionLabelDTO> listFromMaps(
          List<Map<String, Object?>> maps) =>
      maps.map((e) => TransactionLabelDTO.fromMap(e)).toList();

  Map<String, Object> toMap() => {
        'id': id,
        'name': name,
        'colorCode': colorCode,
      };

  TransactionLabel toEntity() => TransactionLabel(
        id: id,
        name: name,
        colorCode: colorCode,
      );

  static const String tableName = 'transaction_labels';

  static const String createTable = '''
    CREATE TABLE $tableName (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      colorCode TEXT NOT NULL
    )
  ''';
}
