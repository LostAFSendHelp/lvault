import 'package:sqflite/sqflite.dart';

import 'package:lvault/data/dtos/dto_export.dart';

class DatabaseService {
  final String _dbName;
  late final Database db;

  DatabaseService({String dbName = 'lvault.db'}) : _dbName = dbName;

  void initialize() async {
    db = await openDatabase(
        _dbName, // open using relative path to `getDatabasesPath()`
        version: 1,
        onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
        onCreate: (db, version) async {
          db.transaction((txn) async {
            txn.execute(PocketDTO.createTable);
            txn.execute(SnapshotDTO.createTable);
            txn.execute(TransactionDTO.createTable);
            txn.execute(TransactionLabelDTO.createTable);
          });
        });
  }
}
