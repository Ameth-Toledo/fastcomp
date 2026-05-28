import 'dart:convert';

import '../../../../../core/error/app_exception.dart';
import '../../../../../core/network/api_client.dart';
import 'model/login_request_dto.dart';
import 'model/login_response_dto.dart';
import 'model/register_request_dto.dart';
import 'model/register_response_dto.dart';

class AuthRemoteDatasource {
  final ApiClient apiClient;

  AuthRemoteDatasource({required this.apiClient});

  Future<LoginResponseDto> login(LoginRequestDto request) async {
    final response = await apiClient.post('/auth/login', body: request.toJson());

    switch (response.statusCode) {
      case 200:
        final dto = LoginResponseDto.fromJson(jsonDecode(response.body));
        if (dto.token != null) apiClient.setToken(dto.token!);
        return dto;
      case 401:
        throw const AppException('Correo o contraseña incorrectos.');
      case 400:
        throw const AppException('Datos inválidos. Verifica los campos.');
      default:
        throw const AppException('Error del servidor. Intenta más tarde.');
    }
  }

  Future<RegisterResponseDto> register(RegisterRequestDto request) async {
    final response = await apiClient.post('/auth/register', body: request.toJson());

    switch (response.statusCode) {
      case 201:
        return RegisterResponseDto.fromJson(jsonDecode(response.body));
      case 409:
        throw const AppException('Ya existe una cuenta con ese correo.');
      case 400:
        throw const AppException('Datos inválidos. Verifica los campos.');
      default:
        throw const AppException('Error del servidor. Intenta más tarde.');
    }
  }
}
