import 'user_response_dto.dart';

class RegisterResponseDto {
  final String message;
  final UserResponseDto user;

  const RegisterResponseDto({required this.message, required this.user});

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) => RegisterResponseDto(
        message: json['message'],
        user: UserResponseDto.fromJson(json['user']),
      );
}
