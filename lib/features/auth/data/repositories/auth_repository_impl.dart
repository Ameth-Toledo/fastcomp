import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';
import '../datasource/remote/mapper/login_response_mapper.dart';
import '../datasource/remote/mapper/register_response_mapper.dart';
import '../datasource/remote/model/login_request_dto.dart';
import '../datasource/remote/model/register_request_dto.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDatasource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthUser> login({required String email, required String password}) async {
    final dto = await remoteDataSource.login(
      LoginRequestDto(email: email, password: password),
    );
    return dto.toEntity();
  }

  @override
  Future<AuthUser> register({
    required String firstName,
    required String lastName,
    required String businessName,
    required String email,
    required String password,
    required String phone,
    String? website,
  }) async {
    final dto = await remoteDataSource.register(
      RegisterRequestDto(
        firstName: firstName,
        lastName: lastName,
        businessName: businessName,
        email: email,
        password: password,
        phone: phone,
        website: website,
      ),
    );
    return dto.toEntity();
  }
}
