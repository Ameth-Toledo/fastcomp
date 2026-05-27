import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';
import '../datasource/remote/model/login_request_dto.dart';
import '../datasource/remote/model/register_request_dto.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDatasource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthSession> login({required String email, required String password}) async {
    final dto = await remoteDataSource.login(
      LoginRequestDto(email: email, password: password),
    );
    return AuthSession(
      accessToken: dto.accessToken,
      refreshToken: dto.refreshToken,
      tokenType: dto.tokenType,
      user: AuthUser(
        id: dto.user.id,
        name: dto.user.name,
        lastName: dto.user.lastName,
        email: dto.user.email,
        role: dto.user.role,
        profileImage: dto.user.profileImage,
        oauthProvider: dto.user.oauthProvider,
      ),
    );
  }

  @override
  Future<AuthUser> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
    String? dialCode,
    String? phoneNumber,
  }) async {
    final dto = await remoteDataSource.register(
      RegisterRequestDto(
        name: name,
        lastName: lastName,
        email: email,
        password: password,
        dialCode: dialCode,
        phoneNumber: phoneNumber,
      ),
    );
    return AuthUser(
      id: dto.id,
      name: dto.name,
      lastName: dto.lastName,
      email: dto.email,
      role: dto.role,
    );
  }
}
