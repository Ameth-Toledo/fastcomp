import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

class RegisterUseCase {
  final IAuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<AuthUser> call({
    required String name,
    required String lastName,
    required String email,
    required String password,
    String? dialCode,
    String? phoneNumber,
  }) =>
      repository.register(
        name: name,
        lastName: lastName,
        email: email,
        password: password,
        dialCode: dialCode,
        phoneNumber: phoneNumber,
      );
}
