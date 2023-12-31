import 'package:lvault/domain/entities/pocket.dart';

abstract class PocketRepoExpected {
  Future<List<Pocket>> getAll();

  Future<Pocket> create({required String name, required double balance});

  Future<void> update({required Pocket pocket});

  Future<void> delete({required String pocketId});
}
