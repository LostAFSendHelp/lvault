import 'package:lvault/domain/entities/Pocket.dart';

abstract class PocketRepoExpected {
  Future<List<Pocket>> getAll();
}
