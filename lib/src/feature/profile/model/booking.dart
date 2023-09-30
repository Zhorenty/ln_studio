import 'package:flutter/foundation.dart';

import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';
import 'package:ln_studio/src/feature/salon/models/salon.dart';

@immutable
final class BookingModel {
  const BookingModel({
    required this.id,
    required this.dateAt,
    required this.price,
    required this.salon,
    required this.employee,
    required this.service,
    required this.timeblock,
    this.comment,
  });

  ///
  final int id;

  ///
  final DateTime dateAt;

  ///
  final int price;

  ///
  final String? comment;

  ///
  final Salon salon;

  ///
  final EmployeeModel employee;

  ///
  final ServiceModel service;

  ///
  final EmployeeTimeblock$Response timeblock;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'],
        dateAt: DateTime.parse(json['date_at'] as String),
        price: json['price'],
        comment: json['comment'],
        salon: Salon.fromJson(json['salon']),
        employee: EmployeeModel.fromJson(json['employee']),
        service: ServiceModel.fromJson(json['service']),
        timeblock: EmployeeTimeblock$Response.fromJson(json['timeblock']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_at': dateAt.jsonFormat(),
        'price': price,
        'comment': comment,
        'salon': salon.toJson(),
        'employee': employee.toJson(),
        'service': service.toJson(),
        'timeblock': timeblock.toJson(),
      };
}
