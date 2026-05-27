import '../entities/auth_session.dart';
import '../repositories/i_auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase({required this.repository});

  Future<AuthSession> call({
    required String email,
    required String password,
  }) =>
      repository.login(email: email, password: password);
}
