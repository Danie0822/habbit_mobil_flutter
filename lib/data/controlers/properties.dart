import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/data/models/properties_small.dart';
import 'package:habbit_mobil_flutter/data/models/send_chat.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

// Clase para manejar las propiedades y sus detalles
class PropertiesService {
  // Método para obtener todas las propiedades del cliente actual
  Future<List<PropertiesResponse>> getProperties() async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();

      if (idCliente == null) {
        throw Exception('Client ID is null');
      }

      // Define el payload de la solicitud con el ID del cliente
      final formData = {'id_cliente': idCliente};

      // Envía los datos a la API usando una solicitud POST
      final response = await ApiService.sendData(
        '/propiedades/movil',
        'POST',
        formData,
      );

      // Verifica que la respuesta tenga la estructura esperada
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          // Convierte la lista de datos a una lista de objetos PropertiesResponse
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

  Future<List<PropertiesSmallResponse>> getPropertiesRecently() async {
    try {
      final response = await ApiService.fetchData('/propiedades/movil/reciente');
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          return PropertiesSmallResponse.fromJsonList(data);
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

  Future<List<PropertiesSmallResponse>> getPropertiesPopular() async {
    try {
      final response = await ApiService.fetchData('/propiedades/movil/propiedades/deseadas');
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          return PropertiesSmallResponse.fromJsonList(data);
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

  // Método para obtener propiedades con un filtro específico (filt1)
  Future<List<PropertiesResponse>> getPropertiesInm() async {
    try {
      // Realiza una solicitud GET al endpoint '/propiedades/movilFilt1'
      final response = await ApiService.fetchData('/propiedades/movilFilt1');

      // Verifica la estructura de la respuesta
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

  // Método para obtener propiedades usando filtros de categoría, zona, precio mínimo y máximo
  Future<List<PropertiesResponse>> getPropertiesFilters(
      category, zone, min, max) async {
    try {
      // Define los datos para los filtros
      final data = {
        'categoria': category,
        'zona': zone,
        'min': min,
        'max': max
      };

      // Envía los datos a la API usando una solicitud POST
      final response =
          await ApiService.sendData('/propiedades/movilFilt3', 'POST', data);

      // Verifica la estructura de la respuesta
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

  // Método para obtener propiedades que son proyectos (filt2)
  Future<List<PropertiesResponse>> getPropertiesProyects() async {
    try {
      // Realiza una solicitud GET al endpoint '/propiedades/movilFilt2'
      final response = await ApiService.fetchData('/propiedades/movilFilt2');

      // Verifica la estructura de la respuesta
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

  // Método para obtener propiedades favoritas del cliente actual
  Future<List<PropertiesResponse>> getPropertiesFavorites() async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();

      if (idCliente == null) {
        throw Exception('Client ID is null');
      }

      // Define el payload de la solicitud con el ID del cliente
      final formData = {'id_cliente': idCliente};

      // Envía los datos a la API usando una solicitud POST
      final response = await ApiService.sendData(
        '/propiedades/movilFavoritos',
        'POST',
        formData,
      );

      // Verifica la estructura de la respuesta
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

  // Método para agregar una propiedad a los favoritos del cliente
  Future<bool> addPropertyToFavorites(int idPropiedad) async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();

      if (idCliente == null) {
        throw Exception('Client ID is null');
      }

      // Define el payload de la solicitud con el ID del cliente y de la propiedad
      final formData = {
        'id_cliente': idCliente,
        'id_propiedad': idPropiedad,
      };

      // Envía los datos a la API usando una solicitud POST
      final response = await ApiService.sendData(
        '/propiedades/agregarFavorito',
        'POST',
        formData,
      );

      // Convierte la respuesta en el modelo SendChatResponse
      final loginResponse = SendChatResponse.fromJson(response);
      if (loginResponse.success) {
        return true; // Retorna true si la propiedad se agregó correctamente
      } else {
        return false; // Retorna false si no se pudo agregar la propiedad
      }
    } catch (error) {
      throw Exception('Error adding property to favorites: $error');
    }
  }
}
