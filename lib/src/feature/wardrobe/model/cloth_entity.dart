import 'package:flutter/material.dart';

/// Type of wardrobe item.
enum ClothType {
  headdress('headdress'),
  outerwear('outerwear'),
  accessories('accessories');

  const ClothType(this.value);

  /// The value of the enum
  final String value;

  /// Converts a string value to the corresponding enum value.
  static ClothType fromString(String value) => switch (value) {
        'headdress' => headdress,
        'outerwear' => outerwear,
        'accessories' => accessories,
        _ => throw ArgumentError.value(value),
      };

  @override
  String toString() => value;
}

/// Wardrobe item.
@immutable
base class ClothEntity {
  const ClothEntity({
    required this.id,
    required this.type,
    required this.name,
    required this.color,
    required this.price,
    this.description,
  });

  /// Unique identifier of the wardrobe item.
  final int id;

  /// Name of the wardrobe item.
  final String name;

  /// Description of the wardrobe item.
  final String? description;

  /// Color of the wardrobe item.
  final String color;

  /// Price of the wardrobe item.
  final String price;

  /// Type of the wardrobe item.
  final ClothType type;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          name == other.name &&
          color == other.color &&
          price == other.price &&
          description == other.description;

  @override
  int get hashCode => Object.hashAll([id, type]);
}
