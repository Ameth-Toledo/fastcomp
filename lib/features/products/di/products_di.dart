import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api_client.dart';
import '../data/datasource/remote/products_remote_datasource.dart';
import '../data/repositories/products_repository_impl.dart';
import '../domain/usecases/get_products_usecase.dart';
import '../presentation/providers/products_provider.dart';

class ProductsDI {
  static Widget inject({required ApiClient apiClient, required Widget child}) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(
        getProductsUseCase: GetProductsUseCase(
          repository: ProductsRepositoryImpl(
            remoteDataSource: ProductsRemoteDatasource(
              apiClient: apiClient,
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
