import 'package:flutter/foundation.dart';

///
@immutable
final class Profile {
  const Profile({
    required this.code,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.birthDate,
    this.email,
  });

  /// TODO: comment, passport, agreement, registration address not implemented
  /// yet.

  ///
  final String code;

  ///
  final String firstName;

  ///
  final String lastName;

  ///
  final String phone;

  ///
  final DateTime? birthDate;

  ///
  final String? email;

  ///
  factory Profile.fromJson(Map<String, Object?> json) => Profile(
        code: json['code'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        phone: json['phone'] as String,
        birthDate: json['birthDate'] as DateTime,
        email: json['email'] as String,
      );

  ///
  Map<String, Object?> toJson() => {
        'code': code,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'birthDate': birthDate?.toIso8601String(),
        'email': email,
      };

  @override
  String toString() =>
      'Profile(code: $code, email: $email, firstName: $firstName, lastName: $lastName, phone: $phone ,birthDate: $birthDate)';
}
