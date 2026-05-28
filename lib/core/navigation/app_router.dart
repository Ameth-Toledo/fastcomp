import 'package:flutter/material.dart';

import '../../features/auth/di/auth_di.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/products/di/products_di.dart';
import '../../features/products/domain/entities/product.dart';
import '../../features/products/presentation/pages/add_product_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../network/api_client.dart';
import 'app_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> routes(ApiClient apiClient) => {
        AppRoutes.login: (_) => AuthDI.inject(
              apiClient: apiClient,
              child: const LoginPage(),
            ),
        AppRoutes.register: (_) => AuthDI.inject(
              apiClient: apiClient,
              child: const RegisterPage(),
            ),
        AppRoutes.products: (_) => ProductsDI.inject(
              apiClient: apiClient,
              child: const ProductsPage(),
            ),
        AppRoutes.addProduct: (_) => ProductsDI.inject(
              apiClient: apiClient,
              child: const AddProductPage(),
            ),
        AppRoutes.productDetail: (ctx) {
          final product = ModalRoute.of(ctx)!.settings.arguments as Product;
          return ProductsDI.inject(
            apiClient: apiClient,
            child: ProductDetailPage(product: product),
          );
        },
        AppRoutes.editProduct: (ctx) {
          final product = ModalRoute.of(ctx)!.settings.arguments as Product;
          return ProductsDI.inject(
            apiClient: apiClient,
            child: AddProductPage(product: product),
          );
        },
      };
}
