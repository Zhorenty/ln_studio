import 'package:flutter/material.dart';

///
@immutable
final class EmployeeTimetable {
  const EmployeeTimetable({required this.workDate});

  ///
  final DateTime workDate;

  ///
  factory EmployeeTimetable.fromJson(Map<String, dynamic> json) {
    return EmployeeTimetable(
      workDate: json['work_date'],
    );
  }
}

///
@immutable
final class EmployeeTimeblock {
  const EmployeeTimeblock({
    required this.dateAt,
    required this.employeeId,
    required this.salonId,
  });

  ///
  final DateTime dateAt;

  ///
  final int employeeId;

  ///
  final int salonId;

  ///
  factory EmployeeTimeblock.fromJson(Map<String, dynamic> json) {
    return EmployeeTimeblock(
      dateAt: DateTime.parse(json['work_date'] as String),
      employeeId: json['employee_id'] as int,
      salonId: json['salon_id'] as int,
    );
  }
}
