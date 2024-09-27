import 'package:habbit_mobil_flutter/data/models/prices.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

// Clase para manejar los datos relacionados con precios
class DataPrices {
  // Método para obtener el rango de precios
  Future<PrecioRange> fetchPrecioRange() async {
    try {
      // Realiza una petición al endpoint '/preferencias/precios/' usando el servicio de API
      final response = await ApiService.fetchData('/preferencias/precios/');

      // Asegúrate de verificar el 'success' en el nivel correcto
      if (response['success'] == true && response['data'] is Map) {
        // Accede al JSON anidado que contiene los datos
        final nestedResponse = response['data'];

        // Verifica si la respuesta anidada también es exitosa y si contiene una lista de datos
        if (nestedResponse['success'] == true && nestedResponse['data'] is List) {
          final List<dynamic> data = nestedResponse['data'];

          // Verifica si la lista no está vacía y contiene un mapa válido
          if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
            // Convierte el primer elemento de la lista en un objeto PrecioRange
            return PrecioRange.fromJson(data[0]);
          } else {
            // Lanza una excepción si no se encontraron datos en la respuesta
            throw Exception('No se encontraron datos en la respuesta');
          }
        } else {
          // Lanza una excepción si la estructura de la respuesta es inesperada en el nivel anidado
          throw Exception('Estructura de respuesta inesperada en el nivel anidado');
        }
      } else {
        // Lanza una excepción si la estructura de la respuesta es inesperada
        throw Exception('Estructura de respuesta inesperada');
      }
    } catch (error) {
      // Captura cualquier error y lanza una excepción con el mensaje de error
      throw Exception('Error al obtener el rango de precios: $error');
    }
  }
}
