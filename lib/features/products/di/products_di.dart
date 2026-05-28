import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api_client.dart';
import '../data/datasource/remote/products_remote_datasource.dart';
import '../data/repositories/products_repository_impl.dart';
import '../domain/usecases/create_product_usecase.dart';
import '../domain/usecases/get_products_usecase.dart';
import '../presentation/providers/add_product_provider.dart';
import '../presentation/providers/products_provider.dart';

class ProductsDI {
  static Widget inject({required ApiClient apiClient, required Widget child}) {
    final repository = ProductsRepositoryImpl(
      remoteDataSource: ProductsRemoteDatasource(apiClient: apiClient),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(
            getProductsUseCase: GetProductsUseCase(repository: repository),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddProductProvider(
            createProductUseCase: CreateProductUseCase(repository: repository),
          ),
        ),
      ],
      child: child,
    );
  }
}
