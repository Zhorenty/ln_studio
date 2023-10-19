import 'package:flutter/foundation.dart';

typedef TokenPair = ({
  String accessToken,
  String? refreshToken,
});

@immutable
final class User {
  const User({
    this.id,
    this.photo,
    this.phone,
    this.firstName,
    this.lastName,
    this.birthDate,
  });

  final int? id;

  final String? phone;

  final String? photo;

  final String? firstName;

  final String? lastName;

  final DateTime? birthDate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && phone == other.phone;

  @override
  int get hashCode => phone.hashCode;
}
