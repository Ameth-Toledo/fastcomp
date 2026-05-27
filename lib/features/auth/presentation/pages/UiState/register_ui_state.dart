import '../../../domain/entities/auth_user.dart';

sealed class RegisterUiState {
  const RegisterUiState();
}

class RegisterIdle extends RegisterUiState {
  const RegisterIdle();
}

class RegisterLoading extends RegisterUiState {
  const RegisterLoading();
}

class RegisterData extends RegisterUiState {
  final AuthUser user;
  const RegisterData(this.user);
}

class RegisterError extends RegisterUiState {
  final String message;
  const RegisterError(this.message);
}
