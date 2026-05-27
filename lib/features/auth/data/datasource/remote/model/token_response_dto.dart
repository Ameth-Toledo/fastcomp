import 'user_response_dto.dart';

class TokenResponseDto {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final UserResponseDto user;

  const TokenResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.user,
  });

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) => TokenResponseDto(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
        tokenType: json['token_type'],
        user: UserResponseDto.fromJson(json['user']),
      );
}
