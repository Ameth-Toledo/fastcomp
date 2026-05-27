import 'dart:convert';

import '../../../../../core/network/api_client.dart';
import 'model/login_request_dto.dart';
import 'model/register_request_dto.dart';
import 'model/register_response_dto.dart';
import 'model/token_response_dto.dart';

class AuthRemoteDatasource {
  final ApiClient apiClient;

  AuthRemoteDatasource({required this.apiClient});

  Future<TokenResponseDto> login(LoginRequestDto request) async {
    final response = await apiClient.post('/auth/login', body: request.toJson());
    return TokenResponseDto.fromJson(jsonDecode(response.body));
  }

  Future<RegisterResponseDto> register(RegisterRequestDto request) async {
    final response = await apiClient.post('/auth/register', body: request.toJson());
    return RegisterResponseDto.fromJson(jsonDecode(response.body));
  }
}
