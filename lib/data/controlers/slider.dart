import 'package:habbit_mobil_flutter/data/models/slider.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class SliderServices {
  // Método para cargar chats del cliente
  Future<List<SliderResponse>> cargarCards(selectedZoneId, selectedCategoryId, precioMin, precioMax,
  distancia, selectedEstadoPropiedadValue, selectedTipoPropiedadValue, latitud, longitud) async {
    try {
      // Define el payload del mensaje
      final body = {
        'p_estado_propiedad': selectedEstadoPropiedadValue,
        'p_tipo_propiedad': selectedTipoPropiedadValue,
        'p_id_zona': selectedZoneId,
        'p_id_categoria': selectedCategoryId,
        'p_latitud_usuario': latitud,
        'p_longitud_usuario': longitud,
        'p_distancia_max': distancia,
        'p_precio_min': precioMin,
        'p_precio_max': precioMax,
      };

      // Envía los datos a la API
      final response = await ApiService.sendData(
        '/propiedades/slider/cliente',
        'POST',
        body,
      );

      // Extrae los datos internos de la respuesta
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          // Convierte la lista de datos en una lista de MessageResponse y la retorna
          return SliderResponse.fromJsonList(data);
        } else {
          // Lanza una excepción si la respuesta no es la esperada
          throw Exception('Respuesta inesperada de la API');
        }
      } else {
        // Lanza una excepción si la respuesta no es la esperada
        throw Exception('Respuesta inesperada de la API');
      }
    } catch (error) {
      // Lanza una excepción en caso de error
      throw Exception('Error al cargar cards: $error');
    }
  }

}
