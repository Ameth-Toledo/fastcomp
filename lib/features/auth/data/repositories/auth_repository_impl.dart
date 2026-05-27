import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';
import '../datasource/remote/mapper/register_response_mapper.dart';
import '../datasource/remote/mapper/token_response_mapper.dart';
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
    return dto.toEntity();
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
    return dto.toEntity();
  }
}
