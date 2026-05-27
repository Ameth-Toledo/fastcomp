import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import 'app_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.login: (_) => const LoginPage(),
        AppRoutes.register: (_) => const RegisterPage(),
        AppRoutes.products: (_) => const Placeholder(),
        AppRoutes.productDetail: (_) => const Placeholder(),
      };
}
