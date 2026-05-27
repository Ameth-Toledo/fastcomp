import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.products: (_) => const Placeholder(),
        AppRoutes.productDetail: (_) => const Placeholder(),
      };
}
