import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'api_constants.dart';

class ApiClient {
  final http.Client _client;
  final String _baseUrl;

  String? _token;

  ApiClient({http.Client? client})
      : _client = client ?? http.Client(),
        _baseUrl = ApiConstants.baseUrl;

  void setToken(String token) => _token = token;

  void clearToken() => _token = null;

  bool get isAuthenticated => _token != null;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_token case final token?) 'Authorization': 'Bearer $token',
      };

  Future<http.Response> get(String endpoint) {
    return _client.get(Uri.parse('$_baseUrl$endpoint'), headers: _headers);
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
    return _client.delete(Uri.parse('$_baseUrl$endpoint'), headers: _headers);
  }

  Future<http.Response> putMultipart(
    String endpoint, {
    required Map<String, String> fields,
    Uint8List? imageBytes,
    String? imageFilename,
  }) async {
    final request = http.MultipartRequest('PUT', Uri.parse('$_baseUrl$endpoint'));
    if (_token case final token?) request.headers['Authorization'] = 'Bearer $token';
    request.fields.addAll(fields);
    if (imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: imageFilename ?? 'image.jpg',
      ));
    }
    final streamed = await _client.send(request);
    return http.Response.fromStream(streamed);
  }

  Future<http.Response> postMultipart(
    String endpoint, {
    required Map<String, String> fields,
    Uint8List? imageBytes,
    String? imageFilename,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse('$_baseUrl$endpoint'));
    if (_token case final token?) request.headers['Authorization'] = 'Bearer $token';
    request.fields.addAll(fields);
    if (imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: imageFilename ?? 'image.jpg',
      ));
    }
    final streamed = await _client.send(request);
    return http.Response.fromStream(streamed);
  }

  void dispose() => _client.close();
}
