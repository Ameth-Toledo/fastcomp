import '../../../../domain/entities/auth_user.dart';
import '../model/user_response_dto.dart';

extension UserResponseDtoMapper on UserResponseDto {
  AuthUser toEntity() => AuthUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        businessName: businessName,
        email: email,
        phone: phone,
        website: website,
        profilePhoto: profilePhoto,
        roleId: roleId,
      );
}
