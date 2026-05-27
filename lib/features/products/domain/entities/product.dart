import 'product_category.dart';
import 'product_condition.dart';

class Product {
  final String id;
  final String brand;
  final String name;
  final ProductCategory category;
  final double price;
  final int stock;
  final ProductCondition condition;
  final bool featured;
  final String? description;
  final List<String> specs;
  final String addedAt;

  const Product({
    required this.id,
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.condition,
    this.featured = false,
    this.description,
    this.specs = const [],
    required this.addedAt,
  });
}
