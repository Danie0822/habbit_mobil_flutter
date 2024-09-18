import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class PropertiesService {
  Future<List<PropertiesResponse>> getProperties() async {
    try {
      final response = await ApiService.fetchData('/propiedades/movil');

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

  Future<List<PropertiesResponse>> getPropertiesInm() async {
    try {
      final response = await ApiService.fetchData('/propiedades/movilFilt1');

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

  Future<List<PropertiesResponse>> getPropertiesFilters(
      category, zone, min, max) async {
    try {
      final data = {'categoria': category, 'zona': zone, 'min': min, 'max': max};
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
}
