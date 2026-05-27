import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase({required this.repository});

  Future<AuthUser> call({required String email, required String password}) =>
      repository.login(email: email, password: password);
}
