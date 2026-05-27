import '../../../../domain/entities/auth_session.dart';
import '../model/token_response_dto.dart';
import 'user_response_mapper.dart';

extension TokenResponseDtoMapper on TokenResponseDto {
  AuthSession toEntity() => AuthSession(
        accessToken: accessToken,
        refreshToken: refreshToken,
        tokenType: tokenType,
        user: user.toEntity(),
      );
}
