/// {@template record_event}
/// RecordEvent class
/// {@endtemplate}
sealed class RecordEvent {
  /// {@macro record_event}
  const RecordEvent();

  factory RecordEvent.create({
    required String dateAt,
    required int salonId,
    required int clientId,
    required int serviceId,
    required int employeeId,
    required int timeblockId,
    required int price,
    String? comment,
  }) = RecordEvent$Create;

  factory RecordEvent.fetchLastBooking() = RecordEvent$FetchLastBooking;
}

final class RecordEvent$Create extends RecordEvent {
  const RecordEvent$Create({
    required this.dateAt,
    required this.clientId,
    required this.salonId,
    required this.serviceId,
    required this.employeeId,
    required this.timeblockId,
    required this.price,
    this.comment,
  });

  final String dateAt;
  final int salonId;
  final int clientId;
  final int serviceId;
  final int employeeId;
  final int timeblockId;
  final int price;
  final String? comment;
}

final class RecordEvent$FetchLastBooking extends RecordEvent {
  const RecordEvent$FetchLastBooking();
}
