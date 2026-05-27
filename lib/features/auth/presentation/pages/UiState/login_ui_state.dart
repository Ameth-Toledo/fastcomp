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

class LoginData extends LoginUiState {
  final AuthSession session;
  const LoginData(this.session);
}

class LoginError extends LoginUiState {
  final String message;
  const LoginError(this.message);
}
