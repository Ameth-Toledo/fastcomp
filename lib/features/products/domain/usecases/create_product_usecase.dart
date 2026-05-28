import 'dart:typed_data';

import '../entities/product.dart';
import '../repositories/i_products_repository.dart';

class CreateProductUseCase {
  final IProductsRepository repository;

  CreateProductUseCase({required this.repository});

  Future<Product> call({
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
  }) =>
      repository.createProduct(
        brand: brand,
        name: name,
        category: category,
        price: price,
        stock: stock,
        condition: condition,
        featured: featured,
        description: description,
        imageBytes: imageBytes,
        imageFilename: imageFilename,
      );
}
