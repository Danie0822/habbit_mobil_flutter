import 'package:habbit_mobil_flutter/data/models/image.dart';
import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

// Clase para manejar los detalles de las propiedades
class PropertiesDetailService {

  // Método asíncrono para obtener los detalles de una propiedad
  Future<List<PropertiesResponse>> getPropertiesDetails(int idPropiedad) async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();

      // Envía los datos al endpoint '/propiedades/movil/detalles' usando el método POST
      final response = await ApiService.sendData(
        '/propiedades/movil/detalles', 
        'POST', 
        {
          'idPropiedad': idPropiedad, // ID de la propiedad
          'id_cliente': idCliente // ID del cliente obtenido
        }
      );

      // Accede al campo 'data' de la respuesta
      final innerData = response['data'];

      // Verifica si el campo 'data' es un mapa con datos válidos
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        // Verifica si el campo 'data' es una lista de propiedades
        if (data is List<dynamic>) {
          // Convierte la lista en objetos PropertiesResponse y los devuelve
          return PropertiesResponse.fromJsonList(data);
        } else {
          throw Exception('Unexpected API response');
        }
      } else {
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      // Maneja cualquier error y lanza una excepción con el mensaje de error
      throw Exception('Error loading properties: $error');
    }
  }

  // Método asíncrono para obtener las imágenes de una propiedad
  Future<List<ImageModel>> getPropertiesDetailsImage(int idPropiedad) async {
    try {
      // Realiza una petición GET al endpoint que devuelve las imágenes de una propiedad
      final response = await ApiService.fetchData('/imagenes/movil/$idPropiedad');

      // Accede al campo 'data' de la respuesta en el primer nivel
      final responseData = response['data'];

      // Verifica si 'data' es un mapa válido
      if (responseData is Map<String, dynamic>) {
        // Accede al segundo nivel de 'data'
        final innerData = responseData['data'];

        // Verifica si el segundo nivel 'data' es un mapa válido
        if (innerData is Map<String, dynamic>) {
          // Convierte los valores del mapa en una lista de objetos ImageModel
          final List<ImageModel> images = innerData.values
              .map((item) => ImageModel.fromJson(item as Map<String, dynamic>))
              .toList();
          return images;
        } else {
          // Lanza una excepción si 'data' no es un mapa
          throw Exception('Unexpected API response: "data" is not a Map');
        }
      } else {
        // Lanza una excepción si 'data' no es un mapa en el primer nivel
        throw Exception('Unexpected API response: "data" is not a Map');
      }
    } catch (error) {
      throw Exception('Error loading properties: $error');
    }
  }
}
