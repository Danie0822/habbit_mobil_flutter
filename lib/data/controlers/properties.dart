import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/data/models/send_chat.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class PropertiesService {
  Future<List<PropertiesResponse>> getProperties() async {
    try {
      final response = await ApiService.fetchData('/propiedades/movil');

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

  Future<List<PropertiesResponse>> getPropertiesInm() async {
    try {
      final response = await ApiService.fetchData('/propiedades/movilFilt1');

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

  Future<List<PropertiesResponse>> getPropertiesFilters(
      category, zone, min, max) async {
    try {
      final data = {
        'categoria': category,
        'zona': zone,
        'min': min,
        'max': max
      };
      final response =
          await ApiService.sendData('/propiedades/movilFilt3', 'POST', data);

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

  Future<List<PropertiesResponse>> getPropertiesProyects() async {
    try {
      final response = await ApiService.fetchData('/propiedades/movilFilt2');

      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        print(data);
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

  Future<List<PropertiesResponse>> getPropertiesFavorites() async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();

      if (idCliente == null) {
        throw Exception('Client ID is null');
      }

      // Define el payload del mensaje
      final formData = {'id_cliente': idCliente};

      // Envía los datos a la API usando POST
      final response = await ApiService.sendData(
        '/propiedades/movilFavoritos',
        'POST', // Cambia a POST
        formData, // Envía el cuerpo de la solicitud
      );

      // Verifica que la respuesta tenga la estructura esperada
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          return PropertiesResponse.fromJsonList(data);
        } else {
          throw Exception('Unexpected data format in response');
        }
      } else {
        throw Exception('Unexpected response structure');
      }
    } catch (error) {
      print('Error loading properties favorites: $error');
      throw Exception('Error loading properties favorites: $error');
    }
  }

  Future<bool> addPropertyToFavorites(int idPropiedad) async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();

      if (idCliente == null) {
        throw Exception('Client ID is null');
      }

      // Define el payload del mensaje
      final formData = {
        'id_cliente': idCliente,
        'id_propiedad': idPropiedad,
      };

      // Envía los datos a la API usando POST
      final response = await ApiService.sendData(
        '/propiedades/agregarFavorito',
        'POST', // Cambia a POST
        formData, // Envía el cuerpo de la solicitud
      );
      // Convertir la respuesta en el modelo
      final loginResponse = SendChatResponse.fromJson(response);
      if (loginResponse.success) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Error adding property to favorites: $error');
    }
  }
}
