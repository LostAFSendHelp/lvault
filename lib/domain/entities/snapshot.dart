final class Snapshot {
  final String id;
  final String pocketId;
  final int amount;
  final int timestamp;

  const Snapshot({
    required this.id,
    required this.pocketId,
    required this.amount,
    required this.timestamp,
  });
}
