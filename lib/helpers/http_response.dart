class HttpResponse {
  final dynamic data; // Almacena la información de la respuesta HTTP
  final HttpError error; // Almacena información sobre errores

  HttpResponse({required this.data, required this.error});

  // Método para crear una instancia de HttpResponse en caso de respuesta exitosa
  static HttpResponse success(dynamic data) => HttpResponse(
      data: data, error: HttpError(statusCode: 0, message: "", data: null));

  // Método para crear una instancia de HttpResponse en caso de respuesta con errores
  static HttpResponse fail({
    required int statusCode,
    required String message,
    required dynamic data,
  }) =>
      HttpResponse(
          data: null,
          error: HttpError(
            statusCode: statusCode,
            message: message,
            data: data,
          ));
}

class HttpError {
  final int statusCode; // Código de estado HTTP que indica el error
  final String message; // Mensaje descriptivo que explica el error
  final dynamic data; // Datos adicionales relacionados con el error

  HttpError({
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
