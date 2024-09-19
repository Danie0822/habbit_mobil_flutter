import 'dart:convert';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiService {
  // Variable para controlar si se está realizando una petición
  static bool isFetchingData = false;

  // Cola de peticiones
  static List<Function> requestQueue = [];

  // Método para obtener datos
  static Future<Map<String, dynamic>> fetchData(String endpoint) async {
    return await _queueRequest(() async {
      return await _fetchDataWithOptions(endpoint, {
        'headers': {
          'Authorization': 'Bearer ${await StorageService.getToken()}'
        }
      });
    });
  }

  // Método para enviar datos
  static Future<Map<String, dynamic>> sendData(String endpoint, String method, Map<String, dynamic>? formData) async {
    return await _queueRequest(() async {
      return await _fetchDataWithOptions(endpoint, {
        'method': method,
        'headers': {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await StorageService.getToken()}'
        },
        'body': formData != null ? jsonEncode(formData) : null,
      });
    });
  }

  // Método para enviar datos con API Key
  static Future<Map<String, dynamic>> sendDataApiKey(String endpoint, String method, Map<String, dynamic>? formData) async {
    return await _queueRequest(() async {
      return await _fetchDataWithOptions(endpoint, {
        'method': method,
        'headers': {
          'Content-Type': 'application/json',
          'x-api-key': Config.apiKey
        },
        'body': formData != null ? jsonEncode(formData) : null,
      });
    });
  }

  // Método para eliminar datos
  static Future<Map<String, dynamic>> deleteData(String endpoint) async {
    return await _queueRequest(() async {
      return await _fetchDataWithOptions(endpoint, {
        'method': 'DELETE',
        'headers': {
          'Authorization': 'Bearer ${await StorageService.getToken()}'
        }
      });
    });
  }

  // Método que añade la petición a la cola
  static Future<Map<String, dynamic>> _queueRequest(Future<Map<String, dynamic>> Function() request) async {
    // Agregamos la petición a la cola
    final completer = Completer<Map<String, dynamic>>();
    requestQueue.add(() => request().then(completer.complete).catchError(completer.completeError));

    // Si no se está ejecutando ninguna petición, ejecutamos la primera
    if (!isFetchingData) {
      _processQueue();
    }

    return completer.future;
  }

  // Método para procesar la cola de peticiones
  static Future<void> _processQueue() async {
    if (requestQueue.isEmpty) return;

    isFetchingData = true;

    // Ejecutamos la primera petición en la cola
    final currentRequest = requestQueue.removeAt(0);
    await currentRequest();

    // Continuamos con la siguiente petición
    isFetchingData = false;
    if (requestQueue.isNotEmpty) {
      _processQueue();
    }
  }

  // Método para manejar las peticiones
  static Future<Map<String, dynamic>> _fetchDataWithOptions(String endpoint, Map<String, dynamic> options) async {
    try {
      final uri = Uri.parse('${Config.baseURL}$endpoint');
      final response = await _makeRequest(uri, options);

      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    } 
  }

  // Método para realizar la petición
  static Future<http.Response> _makeRequest(Uri uri, Map<String, dynamic> options) {
    final method = options['method'] ?? 'GET';
    final headers = options['headers'] ?? {};
    final body = options['body'];

    switch (method) {
      case 'POST':
        return http.post(uri, headers: headers, body: body);
      case 'PUT':
        return http.put(uri, headers: headers, body: body);
      case 'DELETE':
        return http.delete(uri, headers: headers);
      case 'PATCH':
        return http.patch(uri, headers: headers, body: body);
      case 'GET':
      default:
        return http.get(uri, headers: headers);
    }
  }

  // Método para manejar la respuesta
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);
    return {'success': response.statusCode == 200, 'data': data};
  }

  // Método para manejar los errores
  static Map<String, dynamic> _handleError(Object error) {
    // ignore: avoid_print
    print("Error: $error");
    return {'success': false, 'message': error.toString()};
  }
}
