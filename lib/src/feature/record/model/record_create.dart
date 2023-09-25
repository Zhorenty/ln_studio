import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';

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
    required this.timeTableItemId,
    required this.date,
    this.comment,
  });

  final int serviceId;

  final int employeeId;

  final int salonId;

  final int clientId;

  final int timeTableItemId;

  final DateTime date;

  final String? comment;

  Map<String, Object?> toJson() => {
        'date_at': date.jsonFormat(),
        'employee_id': employeeId,
        'salon_id': salonId,
        'client_id': clientId,
        'service_id': serviceId,
        'timeblock_id': timeTableItemId,
        'comment': comment,
      };
}
