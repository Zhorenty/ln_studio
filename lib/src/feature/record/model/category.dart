import 'package:flutter/material.dart';

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

///
@immutable
final class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.categoryId,
    required this.photo,
    required this.name,
    required this.price,
    required this.description,
    this.priceWithDiscount,
    this.duration,
  });

  ///
  final int id;

  ///
  final int categoryId;

  ///
  final String photo;

  ///
  final String name;

  ///
  final int price;

  ///
  final int? priceWithDiscount;

  ///
  final String description;

  ///
  final int? duration;

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      categoryId: json['category_id'],
      photo: json['photo'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      priceWithDiscount: json['price_with_discount'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'photo': photo,
      'name': name,
      'price': price,
      'description': description,
      'price_with_discount': priceWithDiscount,
      'duration': duration,
    };
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModel &&
          runtimeType == other.runtimeType &&
          id == other.id;
}
