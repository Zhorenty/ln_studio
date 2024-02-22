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
    required this.isDone,
    required this.isCanceled,
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

  final bool isDone;

  final bool isCanceled;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'],
        dateAt: DateTime.parse(json['date_at']),
        price: json['price'],
        comment: json['comment'],
        salon: Salon.fromJson(json['salon']),
        employee: EmployeeModel.fromJson(json['employee']),
        service: ServiceModel.fromJson(json['service']),
        timeblock: EmployeeTimeblock$Response.fromJson(json['timeblock']),
        isDone: bool.tryParse(json['is_done']) ?? false,
        isCanceled: json['is_canceled'] ?? false,
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
        'is_done': isDone,
      };

  BookingModel copyWith({
    int? id,
    DateTime? dateAt,
    int? price,
    String? comment,
    Salon? salon,
    EmployeeModel? employee,
    ServiceModel? service,
    EmployeeTimeblock$Response? timeblock,
    bool? isDone,
    bool? isCanceled,
  }) =>
      BookingModel(
        id: id ?? this.id,
        dateAt: dateAt ?? this.dateAt,
        price: price ?? this.price,
        comment: comment ?? this.comment,
        salon: salon ?? this.salon,
        employee: employee ?? this.employee,
        service: service ?? this.service,
        timeblock: timeblock ?? this.timeblock,
        isDone: isDone ?? this.isDone,
        isCanceled: isCanceled ?? this.isCanceled,
      );
}
