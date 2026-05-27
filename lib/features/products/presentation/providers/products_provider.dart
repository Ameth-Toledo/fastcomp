import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';

class ProductsProvider extends ChangeNotifier {
  final GetProductsUseCase getProductsUseCase;

  ProductsProvider({required this.getProductsUseCase});

  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await getProductsUseCase();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
