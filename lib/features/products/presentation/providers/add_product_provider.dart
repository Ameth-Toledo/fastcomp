import 'package:flutter/foundation.dart';

import '../../../../core/error/error_handler.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../pages/UiState/add_product_ui_state.dart';

class AddProductProvider extends ChangeNotifier {
  final CreateProductUseCase createProductUseCase;

  AddProductProvider({required this.createProductUseCase});

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

  void reset() {
    _state = const AddProductIdle();
    notifyListeners();
  }
}
