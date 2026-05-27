import '../../../../domain/entities/auth_user.dart';
import '../model/user_response_dto.dart';

extension UserResponseDtoMapper on UserResponseDto {
  AuthUser toEntity() => AuthUser(
        id: id,
        name: name,
        lastName: lastName,
        email: email,
        role: role,
        profileImage: profileImage,
        oauthProvider: oauthProvider,
      );
}
