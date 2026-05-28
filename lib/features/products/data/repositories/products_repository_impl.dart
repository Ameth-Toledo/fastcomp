import 'dart:typed_data';

import '../../domain/entities/product.dart';
import '../../domain/repositories/i_products_repository.dart';
import '../datasource/remote/mapper/products_mapper.dart';
import '../datasource/remote/products_remote_datasource.dart';

class ProductsRepositoryImpl implements IProductsRepository {
  final ProductsRemoteDatasource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    final dtos = await remoteDataSource.getProducts();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
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
  }) async {
    final dto = await remoteDataSource.createProduct(
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
    return dto.toEntity();
  }
}
