import 'package:flutter/foundation.dart';

import '/src/common/utils/extensions/date_time_extension.dart';

@immutable
final class ProfileModel {
  const ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.email,
  });

  ///
  final String firstName;

  ///
  final String lastName;

  ///
  final DateTime birthDate;

  ///
  final String email;

  ///
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        firstName: json['first_name'],
        lastName: json['last_name'],
        birthDate: DateTime.parse(json['birth_date']),
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'birth_date': birthDate.jsonFormat(),
        'email': email,
      };
}