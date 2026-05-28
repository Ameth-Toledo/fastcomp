import '../repositories/i_products_repository.dart';

class DeleteProductUseCase {
  final IProductsRepository repository;

  DeleteProductUseCase({required this.repository});

  Future<void> call(String id) => repository.deleteProduct(id);
}
