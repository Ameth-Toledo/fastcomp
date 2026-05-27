import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class ApiClient {
  final http.Client _client;
  final String _baseUrl;

  String? _cookie;

  ApiClient({http.Client? client})
      : _client = client ?? http.Client(),
        _baseUrl = ApiConstants.baseUrl;

  void setCookie(String setCookieHeader) {
    // Set-Cookie llega como "token=eyJ...; Path=/; HttpOnly"
    // Solo necesitamos la parte "name=value" para enviarla de vuelta
    _cookie = setCookieHeader.split(';').first.trim();
  }

  void clearCookie() => _cookie = null;

  bool get isAuthenticated => _cookie != null;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_cookie case final cookie?) 'Cookie': cookie,
      };

  Future<http.Response> get(String endpoint) {
    return _client.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _headers,
    );
  }

  Future<http.Response> post(String endpoint, {Object? body}) {
    return _client.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> put(String endpoint, {Object? body}) {
    return _client.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> delete(String endpoint) {
    return _client.delete(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _headers,
    );
  }

  void dispose() => _client.close();
}
