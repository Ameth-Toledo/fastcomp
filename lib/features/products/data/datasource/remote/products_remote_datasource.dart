import 'dart:convert';
import 'dart:typed_data';

import '../../../../../core/error/app_exception.dart';
import '../../../../../core/network/api_client.dart';
import 'model/product_dto.dart';

class ProductsRemoteDatasource {
  final ApiClient apiClient;

  ProductsRemoteDatasource({required this.apiClient});

  Future<List<ProductDto>> getProducts() async {
    final response = await apiClient.get('/products');
    final decoded = jsonDecode(response.body);
    if (decoded == null) return [];
    final body = decoded as List<dynamic>;
    return body.map((json) => ProductDto.fromJson(json)).toList();
  }

  Future<ProductDto> createProduct({
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
    final fields = {
      'brand': brand,
      'name': name,
      'category': category,
      'price': price.toString(),
      'stock': stock.toString(),
      'condition': condition,
      'featured': featured.toString(),
      if (description != null && description.isNotEmpty) 'description': description,
    };

    final response = await apiClient.postMultipart(
      '/products',
      fields: fields,
      imageBytes: imageBytes,
      imageFilename: imageFilename,
    );

    switch (response.statusCode) {
      case 201:
        return ProductDto.fromJson(jsonDecode(response.body));
      case 400:
        throw const AppException('Datos inválidos. Verifica los campos.');
      case 401:
        throw const AppException('Sesión expirada. Inicia sesión de nuevo.');
      default:
        throw const AppException('Error del servidor. Intenta más tarde.');
    }
  }

  Future<void> deleteProduct(String id) async {
    final response = await apiClient.delete('/products/$id');
    switch (response.statusCode) {
      case 200:
        return;
      case 401:
        throw const AppException('Sesión expirada. Inicia sesión de nuevo.');
      case 404:
        throw const AppException('Producto no encontrado.');
      default:
        throw const AppException('Error del servidor. Intenta más tarde.');
    }
  }

  Future<ProductDto> updateProduct({
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
  }) async {
    final fields = {
      'brand': brand,
      'name': name,
      'category': category,
      'price': price.toString(),
      'stock': stock.toString(),
      'condition': condition,
      'featured': featured.toString(),
      if (description != null && description.isNotEmpty) 'description': description,
    };

    final response = await apiClient.putMultipart(
      '/products/$id',
      fields: fields,
      imageBytes: imageBytes,
      imageFilename: imageFilename,
    );

    switch (response.statusCode) {
      case 200:
        return ProductDto.fromJson(jsonDecode(response.body));
      case 400:
        throw const AppException('Datos inválidos. Verifica los campos.');
      case 401:
        throw const AppException('Sesión expirada. Inicia sesión de nuevo.');
      case 404:
        throw const AppException('Producto no encontrado.');
      default:
        throw const AppException('Error del servidor. Intenta más tarde.');
    }
  }
}
