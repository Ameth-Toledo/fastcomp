import '../../../../domain/entities/auth_user.dart';
import '../model/login_response_dto.dart';
import 'user_response_mapper.dart';

extension LoginResponseDtoMapper on LoginResponseDto {
  AuthUser toEntity() => user.toEntity();
}
