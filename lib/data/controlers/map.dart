import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/models/map.dart';

class MapService{
  // Método para cargar propiedades del mapa
  Future<List<MapResponse>> cargarPropeidad(latNE, lngNE, latSW, lngSW) async {
    try {
      // Realiza una solicitud a la API para obtener las propiedades del mapa

      // Define el payload del mensaje
      final body = {
        'latNE': latNE, 
        'lngNE': lngNE,
        'latSW': latSW,
        'lngSW': lngSW
        };

        print('body: $body');

        // Envía los datos a la API
      final response = await ApiService.sendData(
        '/propiedades/mapa/cliente',
        'POST',
        body,
      );

      print('response: $response');

      // Extrae los datos internos de la respuesta
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          // Convierte la lista de datos en una lista de MapResponse y la retorna
          return MapResponse.fromJsonList(data);
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
      throw Exception('Error al cargar propiedades: $error');
    }
    
  }
}