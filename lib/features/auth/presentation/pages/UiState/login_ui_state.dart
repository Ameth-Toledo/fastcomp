import '../../../domain/entities/auth_session.dart';

sealed class LoginUiState {
  const LoginUiState();
}

class LoginIdle extends LoginUiState {
  const LoginIdle();
}

class LoginLoading extends LoginUiState {
  const LoginLoading();
}

class LoginSuccess extends LoginUiState {
  final AuthSession session;
  const LoginSuccess(this.session);
}

class LoginError extends LoginUiState {
  final String message;
  const LoginError(this.message);
}
