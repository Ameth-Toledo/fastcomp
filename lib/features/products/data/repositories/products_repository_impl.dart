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
}
