import '../entities/product.dart';
import '../repositories/i_products_repository.dart';

class GetProductsUseCase {
  final IProductsRepository repository;

  GetProductsUseCase({required this.repository});

  Future<List<Product>> call() => repository.getProducts();
}
