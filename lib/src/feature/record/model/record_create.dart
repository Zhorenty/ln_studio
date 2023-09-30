/// {@template record}
/// Record class
/// {@endtemplate}
final class RecordModel$Create {
  /// {@macro record}
  ///
  const RecordModel$Create({
    required this.serviceId,
    required this.employeeId,
    required this.salonId,
    required this.clientId,
    required this.timeblockId,
    required this.date,
    this.comment,
  });

  final int serviceId;

  final int employeeId;

  final int salonId;

  final int clientId;

  final int timeblockId;

  final String date;

  final String? comment;

  Map<String, Object?> toJson() => {
        'date_at': date,
        'employee_id': employeeId,
        'salon_id': salonId,
        'client_id': clientId,
        'service_id': serviceId,
        'timeblock_id': timeblockId,
        'comment': comment,
        // TODO: Заменить на реальные данные
        'price': 0,
      };
}
