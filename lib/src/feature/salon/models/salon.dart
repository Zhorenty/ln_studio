import 'package:flutter/foundation.dart';

/// Creates a salon with the provided attributes.
@immutable
final class Salon {
  const Salon({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.description,
  });

  /// Unique identifier of the salon.
  final int id;

  /// Code of the salon.
  final String code;

  /// Name of the salon.
  final String name;

  /// Address of the salon.
  final String address;

  /// Phone number of the salon.
  final String phone;

  /// Email of the salon.
  final String email;

  /// Description of the salon.
  final String description;

  /// Creates a `Salon` object from the provided [json].
  factory Salon.fromJson(Map<String, Object?> json) => Salon(
        id: json['id'] as int,
        code: json['code'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        description: json['description'] as String,
      );

  /// Converts the `Salon` object to a JSON map.
  Map<String, Object?> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'address': address,
        'phone': phone,
        'email': email,
        'description': description,
      };

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Salon && runtimeType == other.runtimeType && id == other.id;
}
