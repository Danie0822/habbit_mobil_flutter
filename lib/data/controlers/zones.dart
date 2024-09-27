import 'package:habbit_mobil_flutter/data/models/zone.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class ZonesSerivce   {
  // Obtener las zonas desde el servidor
  Future<List<Zone>> getZones() async {
    try {
      // Realiza una solicitud a la API para obtener las zonas
      final response = await ApiService.fetchData('/zonas');
      // Extrae los datos internos de la respuesta
      final innerData = response['data'];
      // Verifica si los datos internos son del tipo esperado
      if (innerData is Map<String, dynamic>) {
        // Extrae los datos internos de la respuesta
        final data = innerData['data'];
        // Verifica si los datos son del tipo esperado
        if (data is List<dynamic>) {
          // Convierte la lista de datos en una lista de zonas y la retorna
          return Zone.fromJsonList(data);
        } else {
          throw Exception('Unexpected API response');
        }
      } else {
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      throw Exception('Error loading zones: $error');
    }
  }
}
