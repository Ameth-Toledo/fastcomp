import '../entities/auth_session.dart';
import '../entities/auth_user.dart';

abstract class IAuthRepository {
  Future<AuthSession> login({
    required String email,
    required String password,
  });

  Future<AuthUser> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
    String? dialCode,
    String? phoneNumber,
  });
}
