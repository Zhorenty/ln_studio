import 'package:ln_studio/src/feature/initialization/logic/initialization_steps.dart';

class Product {
  const Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, Object?> json) {
    return Product(
      id: json['id']! as int,
      imageUrl: '$kBaseUrl/${json['photo']!}',
      name: json['name']! as String,
      description: json['description']! as String,
      price: json['price']! as int,
    );
  }

  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final int price;
}
