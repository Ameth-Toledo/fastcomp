import '../../../../domain/entities/auth_user.dart';
import '../model/register_response_dto.dart';

extension RegisterResponseDtoMapper on RegisterResponseDto {
  AuthUser toEntity() => AuthUser(
        id: id,
        name: name,
        lastName: lastName,
        email: email,
        role: role,
      );
}
