import '../entities/auth_user.dart';
import '../repositories/i_auth_repository.dart';

class RegisterUseCase {
  final IAuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<AuthUser> call({
    required String firstName,
    required String lastName,
    required String businessName,
    required String email,
    required String password,
    required String phone,
    String? website,
  }) =>
      repository.register(
        firstName: firstName,
        lastName: lastName,
        businessName: businessName,
        email: email,
        password: password,
        phone: phone,
        website: website,
      );
}
