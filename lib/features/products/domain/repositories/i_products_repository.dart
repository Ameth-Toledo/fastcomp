import 'dart:typed_data';

import '../entities/product.dart';

abstract class IProductsRepository {
  Future<List<Product>> getProducts();

  Future<Product> createProduct({
    required String brand,
    required String name,
    required String category,
    required double price,
    required int stock,
    required String condition,
    bool featured = false,
    String? description,
    Uint8List? imageBytes,
    String? imageFilename,
  });

  Future<void> deleteProduct(String id);

  Future<Product> updateProduct({
    required String id,
    required String brand,
    required String name,
    required String category,
    required double price,
    required int stock,
    required String condition,
    bool featured = false,
    String? description,
    Uint8List? imageBytes,
    String? imageFilename,
  });
}
