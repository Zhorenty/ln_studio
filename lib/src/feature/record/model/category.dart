import 'package:flutter/material.dart';

import 'service.dart';

///
@immutable
final class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.service,
  });

  ///
  final int id;

  ///
  final String name;

  ///
  final List<ServiceModel> service;

  ///
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      service: List.from(json['services'] as List)
          .map((e) => ServiceModel.fromJson(e))
          .toList(),
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;
}
