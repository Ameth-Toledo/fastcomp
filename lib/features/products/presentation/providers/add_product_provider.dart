import 'package:flutter/foundation.dart';

import '../../../../core/error/error_handler.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import '../pages/UiState/add_product_ui_state.dart';

class AddProductProvider extends ChangeNotifier {
  final CreateProductUseCase createProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  AddProductProvider({
    required this.createProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  });

  AddProductUiState _state = const AddProductIdle();
  AddProductUiState get state => _state;

  Future<void> createProduct({
    required String brand,
    required String name,
    required String category,
    required double price,
    required int stock,
    required String condition,
    bool featured = false,
    String? description,
    Uint8List? imageBytes,
    String? imageFilename,
  }) async {
    _state = const AddProductLoading();
    notifyListeners();

    try {
      final product = await createProductUseCase(
        brand: brand,
        name: name,
        category: category,
        price: price,
        stock: stock,
        condition: condition,
        featured: featured,
        description: description,
        imageBytes: imageBytes,
        imageFilename: imageFilename,
      );
      _state = AddProductSuccess(product);
    } catch (e) {
      _state = AddProductError(ErrorHandler.getMessage(e));
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateProduct({
    required String id,
    required String brand,
    required String name,
    required String category,
    required double price,
    required int stock,
    required String condition,
    bool featured = false,
    String? description,
    Uint8List? imageBytes,
    String? imageFilename,
  }) async {
    _state = const AddProductLoading();
    notifyListeners();

    try {
      final product = await updateProductUseCase(
        id: id,
        brand: brand,
        name: name,
        category: category,
        price: price,
        stock: stock,
        condition: condition,
        featured: featured,
        description: description,
        imageBytes: imageBytes,
        imageFilename: imageFilename,
      );
      _state = AddProductSuccess(product);
    } catch (e) {
      _state = AddProductError(ErrorHandler.getMessage(e));
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) => deleteProductUseCase(id);

  void reset() {
    _state = const AddProductIdle();
    notifyListeners();
  }
}
