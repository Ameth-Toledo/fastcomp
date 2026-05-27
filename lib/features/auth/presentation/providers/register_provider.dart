import 'package:flutter/foundation.dart';

import '../../../../../core/error/error_handler.dart';
import '../../domain/usecases/register_usecase.dart';
import '../pages/UiState/register_ui_state.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterUseCase registerUseCase;

  RegisterProvider({required this.registerUseCase});

  RegisterUiState _state = const RegisterIdle();
  RegisterUiState get state => _state;

  Future<void> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
    String? dialCode,
    String? phoneNumber,
  }) async {
    _state = const RegisterLoading();
    notifyListeners();

    try {
      final user = await registerUseCase(
        name: name,
        lastName: lastName,
        email: email,
        password: password,
        dialCode: dialCode,
        phoneNumber: phoneNumber,
      );
      _state = RegisterData(user);
    } catch (e) {
      _state = RegisterError(ErrorHandler.getMessage(e));
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _state = const RegisterIdle();
    notifyListeners();
  }
}
