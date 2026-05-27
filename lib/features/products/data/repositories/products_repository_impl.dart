import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/entities/product_condition.dart';
import '../../domain/repositories/i_products_repository.dart';
import '../datasource/remote/products_remote_datasource.dart';

class ProductsRepositoryImpl implements IProductsRepository {
  final ProductsRemoteDatasource remoteDataSource;

  ProductsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    final dtos = await remoteDataSource.getProducts();
    return dtos
        .map((dto) => Product(
              id: dto.id,
              brand: dto.brand,
              name: dto.name,
              category: ProductCategory.fromString(dto.category),
              price: dto.price,
              stock: dto.stock,
              condition: ProductCondition.fromString(dto.condition),
              featured: dto.featured,
              description: dto.description,
              specs: dto.specs,
              addedAt: dto.addedAt,
            ))
        .toList();
  }
}
