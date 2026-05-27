import '../../../domain/entities/auth_user.dart';

sealed class LoginUiState {
  const LoginUiState();
}

class LoginIdle extends LoginUiState {
  const LoginIdle();
}

class LoginLoading extends LoginUiState {
  const LoginLoading();
}

class LoginData extends LoginUiState {
  final AuthUser user;
  const LoginData(this.user);
}

class LoginError extends LoginUiState {
  final String message;
  const LoginError(this.message);
}
