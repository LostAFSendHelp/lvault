import 'package:lvault/domain/entities/snapshot.dart';

abstract class SnapshotRepoExpected {
  Future<List<Snapshot>> getAll();

  Future<List<Snapshot>> findByPocketId(String pocketId);

  Future<List<Snapshot>> findBy({
    String? pocketId,
    int? from,
    int? to,
  });

  Future<Snapshot> create({
    required String pocketId,
    required double balance,
    required int timestamp,
  });

  Future<void> delete({required List<String> ids});

  Future<void> deleteByPocketIds({required List<String> pocketIds});
}
