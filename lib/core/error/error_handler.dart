import 'dart:io';

import 'package:http/http.dart' as http;

import 'app_exception.dart';

class ErrorHandler {
  ErrorHandler._();

  static String getMessage(Object error) {
    if (error is AppException) return error.message;
    if (error is SocketException) return 'Sin conexión a internet. Verifica tu red.';
    if (error is http.ClientException) return 'No se pudo conectar al servidor. Intenta más tarde.';
    if (error is FormatException) return 'Respuesta inesperada del servidor.';
    return 'Ocurrió un error inesperado. Intenta de nuevo.';
  }
}
