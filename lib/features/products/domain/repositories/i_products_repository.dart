import '../entities/product.dart';

abstract class IProductsRepository {
  Future<List<Product>> getProducts();
}
