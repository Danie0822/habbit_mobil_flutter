import 'package:habbit_mobil_flutter/data/models/blogs_main.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

// Clase para manejar el servicio de blogs
class BlogsService {
  // Método asíncrono para obtener la lista de blogs
  Future<List<BlogsResponse>> getBlogs() async {
    try {
      // Realiza una petición al endpoint '/blogs/' usando el servicio de API
      final response = await ApiService.fetchData('/blogs/');

      // Obtiene los datos principales de la respuesta
      final innerData = response['data'];

      // Verifica si los datos internos tienen el formato esperado (un mapa)
      if (innerData is Map<String, dynamic>) {
        // Extrae la lista de blogs de los datos internos
        final data = innerData['data'];

        // Verifica si la lista tiene el formato esperado (una lista dinámica)
        if (data is List<dynamic>) {
          // Convierte la lista dinámica a una lista de objetos BlogsResponse
          return BlogsResponse.fromJsonList(data);
        } else {
          // Lanza una excepción si la estructura de la respuesta no es la esperada
          throw Exception('Unexpected API response');
        }
      } else {
        // Lanza una excepción si la estructura de la respuesta no es la esperada
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      // Captura cualquier error y lanza una excepción con el mensaje de error
      throw Exception('Error loading: $error');
    }
  }
}
