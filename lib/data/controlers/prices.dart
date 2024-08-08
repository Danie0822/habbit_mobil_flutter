import 'package:habbit_mobil_flutter/data/models/prices.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class DataPrices {
  // Método para obtener el rango de precios
Future<PrecioRange> fetchPrecioRange() async {
  try {
    final response = await ApiService.fetchData('/preferencias/precios/');
    
    // Imprime la respuesta completa para verificar la estructura
    //print('Response completa: $response');

    // Asegúrate de verificar el 'success' en el nivel correcto
    if (response['success'] == true && response['data'] is Map) {
      final nestedResponse = response['data']; // Accede al JSON anidado
      if (nestedResponse['success'] == true && nestedResponse['data'] is List) {
        final List<dynamic> data = nestedResponse['data'];
        //print('Data: $data');
        
        if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
          return PrecioRange.fromJson(data[0]);
        } else {
          throw Exception('No se encontraron datos en la respuesta');
        }
      } else {
        throw Exception('Estructura de respuesta inesperada en el nivel anidado');
      }
    } else {
      throw Exception('Estructura de respuesta inesperada');
    }
  } catch (error) {
    throw Exception('Error al obtener el rango de precios: $error');
  }
}

}


