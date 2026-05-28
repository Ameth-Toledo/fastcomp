import 'dart:typed_data';

import '../entities/product.dart';
import '../repositories/i_products_repository.dart';

class UpdateProductUseCase {
  final IProductsRepository repository;

  UpdateProductUseCase({required this.repository});

  Future<Product> call({
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
  }) =>
      repository.updateProduct(
        id: id,
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
