import 'user_response_dto.dart';

class LoginResponseDto {
  final String message;
  final UserResponseDto user;

  const LoginResponseDto({required this.message, required this.user});

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) => LoginResponseDto(
        message: json['message'],
        user: UserResponseDto.fromJson(json['user']),
      );
}
