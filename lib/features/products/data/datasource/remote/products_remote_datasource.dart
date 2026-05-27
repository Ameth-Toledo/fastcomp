import 'dart:convert';

import '../../../../../core/network/api_client.dart';
import 'model/product_dto.dart';

class ProductsRemoteDatasource {
  final ApiClient apiClient;

  ProductsRemoteDatasource({required this.apiClient});

  Future<List<ProductDto>> getProducts() async {
    final response = await apiClient.get('/products');
    final List<dynamic> body = jsonDecode(response.body);
    return body.map((json) => ProductDto.fromJson(json)).toList();
  }
}
