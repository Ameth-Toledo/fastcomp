import '../../../domain/entities/product.dart';

sealed class AddProductUiState {
  const AddProductUiState();
}

class AddProductIdle extends AddProductUiState {
  const AddProductIdle();
}

class AddProductLoading extends AddProductUiState {
  const AddProductLoading();
}

class AddProductSuccess extends AddProductUiState {
  final Product product;
  const AddProductSuccess(this.product);
}

class AddProductError extends AddProductUiState {
  final String message;
  const AddProductError(this.message);
}
