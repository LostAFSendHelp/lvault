final class Snapshot {
  final String id;
  final String pocketId;
  final double balance;
  final int timestamp;

  const Snapshot({
    required this.id,
    required this.pocketId,
    required this.balance,
    required this.timestamp,
  });
}
