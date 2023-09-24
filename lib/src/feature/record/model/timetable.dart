import 'package:flutter/material.dart';

/// Timetable element.
@immutable
final class TimetableItem {
  const TimetableItem({
    required this.id,
    required this.dateAt,
    required this.salonId,
    this.salary,
    this.onWork = false,
  });

  /// Employee's ID.
  final int id;

  /// Date when the employee should go to work.
  final DateTime dateAt;

  ///
  final int salonId;

  /// Employee's salary.
  final int? salary;

  /// Indicator whether employee is at work or not.
  final bool onWork;

  /// Return [TimetableItem] from [json].
  factory TimetableItem.fromJson(Map<String, Object?> json) => TimetableItem(
        id: json['id'] as int,
        dateAt: DateTime.parse(json['date_at'] as String),
        salonId: json['salon_id'] as int,
        salary: json['salary'] as int?,
        onWork: json['on_work'] as bool,
      );
}

///
@immutable
final class EmployeeTimeblock$Body {
  const EmployeeTimeblock$Body({
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
  factory EmployeeTimeblock$Body.fromJson(Map<String, dynamic> json) {
    return EmployeeTimeblock$Body(
      dateAt: DateTime.parse(json['date_at'] as String),
      employeeId: json['employee_id'] as int,
      salonId: json['salon_id'] as int,
    );
  }
}

///
@immutable
final class EmployeeTimeblock$Response {
  const EmployeeTimeblock$Response({
    required this.id,
    required this.time,
  });

  ///
  final int id;

  final String time;

  ///
  factory EmployeeTimeblock$Response.fromJson(Map<String, dynamic> json) {
    return EmployeeTimeblock$Response(
      id: json['id'] as int,
      time: json['time'] as String,
    );
  }
}
