import '../entities/auth_user.dart';

abstract class IAuthRepository {
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> register({
    required String firstName,
    required String lastName,
    required String businessName,
    required String email,
    required String password,
    required String phone,
    String? website,
  });
}
