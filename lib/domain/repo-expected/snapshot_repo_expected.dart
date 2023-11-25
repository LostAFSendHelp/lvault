import 'package:lvault/domain/entities/snapshot.dart';

abstract class SnapshotRepoExpected {
  Future<List<Snapshot>> getAll();

  Future<List<Snapshot>> findByPocketId(String pocketId);

  Future<List<Snapshot>> findBy({
    String? pocketId,
    int? from,
    int? to,
  });
}
