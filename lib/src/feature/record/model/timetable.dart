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
