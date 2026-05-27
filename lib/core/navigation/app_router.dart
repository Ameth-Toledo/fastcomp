import 'package:flutter/material.dart';

import '../../features/auth/di/auth_di.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
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
        AppRoutes.products: (_) => const Placeholder(),
        AppRoutes.productDetail: (_) => const Placeholder(),
      };
}
