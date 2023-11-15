import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart' show required;
import 'package:sportifyhub_front/helpers/http_response.dart';

class AuthenticationApi {
  final Dio _dio = Dio(); // Instancia de Dio para realizar solicitudes HTTP.
  final Logger _logger =
      Logger(); // Instancia de Logger para registro de información.

  // Método para registrar un usuario.
  Future<HttpResponse> register({
    @required username,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'https://sportybackenddjango.onrender.com/api/auth/register', // URL de registro.
        data: {
          "username": username,
          "email": email,
          "phone": phone,
          "password": password,
        },
      );
      _logger.i(response.data); // Registra la respuesta exitosa.

      return HttpResponse.success(response.data);
    } catch (e) {
      _logger.e(e); // Registra un error en el registro.

      int statusCode = -1; // Código de estado predeterminado en caso de error.
      String message = "unknown error"; // Mensaje de error predeterminado.
      dynamic data; // Datos adicionales en caso de error.

      if (e is DioException) {
        message = e.message!; // Obtiene el mensaje de error de DioException.
        if (e.response != null) {
          statusCode = e.response!
              .statusCode!; // Obtiene el código de estado de la respuesta.
          message = e.response!
              .statusMessage!; // Obtiene el mensaje de estado de la respuesta.
          data = e.response!.data; // Obtiene datos adicionales de la respuesta.
        }
      }
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }

  // Método para iniciar sesión.
  Future<HttpResponse> login({
    @required username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'https://sportybackenddjango.onrender.com/api/auth/login', // URL de inicio de sesión.
        data: {
          "username": username,
          "password": password,
        },
      );
      _logger.i(response.data); // Registra la respuesta exitosa.

      return HttpResponse.success(response.data);
    } catch (e) {
      _logger.e(e); // Registra un error en el inicio de sesión.

      int statusCode = -1; // Código de estado predeterminado en caso de error.
      String message = "unknown error"; // Mensaje de error predeterminado.
      dynamic data; // Datos adicionales en caso de error.

      if (e is DioException) {
        message = e.message!; // Obtiene el mensaje de error de DioException.
        if (e.response != null) {
          statusCode = e.response!
              .statusCode!; // Obtiene el código de estado de la respuesta.
          message = e.response!
              .statusMessage!; // Obtiene el mensaje de estado de la respuesta.
          data = e.response!.data; // Obtiene datos adicionales de la respuesta.
        }
      }
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
