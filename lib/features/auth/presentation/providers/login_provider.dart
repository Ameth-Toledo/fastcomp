import 'package:flutter/foundation.dart';

import '../../domain/usecases/login_usecase.dart';
import '../pages/UiState/login_ui_state.dart';

class LoginProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginProvider({required this.loginUseCase});

  LoginUiState _state = const LoginIdle();
  LoginUiState get state => _state;

  Future<void> login({required String email, required String password}) async {
    _state = const LoginLoading();
    notifyListeners();

    try {
      final session = await loginUseCase(email: email, password: password);
      _state = LoginData(session);
    } catch (e) {
      _state = LoginError(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    _state = const LoginIdle();
    notifyListeners();
  }
}
