import 'package:habbit_mobil_flutter/data/models/image.dart';
import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class PropertiesDetailService {
  Future<List<PropertiesResponse>> getPropertiesDetails(int idPropiedad) async {
    try {
          // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();
      final response =
          await ApiService.sendData('/propiedades/movil/detalles', 'POST', {'idPropiedad': idPropiedad, 'id_cliente': idCliente});
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          return PropertiesResponse.fromJsonList(data);
        } else {
          throw Exception('Unexpected API response');
        }
      } else {
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      throw Exception('Error loading properties: $error');
    }
  }

 Future<List<ImageModel>> getPropertiesDetailsImage(int idPropiedad) async {
  try {
    final response = await ApiService.fetchData('/imagenes/movil/$idPropiedad');
    print('API response: $response');

    // Acceder al campo 'data' dentro del primer nivel
    final responseData = response['data'];
    if (responseData is Map<String, dynamic>) {
      // Acceder al campo 'data' dentro del segundo nivel
      final innerData = responseData['data'];
      if (innerData is Map<String, dynamic>) {
        // Convertir los datos del mapa a una lista
        final List<ImageModel> images = innerData.values
            .map((item) => ImageModel.fromJson(item as Map<String, dynamic>))
            .toList();
        
        print('images: $images');
        return images;
      } else {
        throw Exception('Unexpected API response: "data" is not a Map');
      }
    } else {
      throw Exception('Unexpected API response: "data" is not a Map');
    }
  } catch (error) {
    print('Error loading properties: $error');
    throw Exception('Error loading properties: $error');
  }
}

}
