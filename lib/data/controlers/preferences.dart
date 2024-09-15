import 'package:habbit_mobil_flutter/data/models/category.dart';
import 'package:habbit_mobil_flutter/data/models/zone.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class DataPreferences {
  // Método para obtener categorías
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await ApiService.fetchData('/categorias/');
      // Verifica si la respuesta tiene la clave 'data'
      if (response['success'] == true) {
        final nestedData = response['data'];
        if (nestedData['success'] == true) {
          List<dynamic> data = nestedData['data'];
          List<Category> categories =
              data.map((item) => Category.fromJson(item)).toList();
          return categories;
        } else {
          throw Exception('Estructura de respuesta inesperada');
        }
      } else {
        throw Exception('Estructura de respuesta inesperada');
      }
    } catch (error) {
      throw Exception('Error al obtener las categorías: $error');
    }
  }

  // Método para obtener zonas 
  Future<List<Zone>> fetchZones() async {
    try {
      final response = await ApiService.fetchData('/zonas/');
      if (response['success'] == true) {
        final nestedData = response['data'];
        if (nestedData['success'] == true) {
          List<dynamic> data = nestedData['data'];
          List<Zone> zones = data.map((item) => Zone.fromJson(item)).toList();
          return zones;
        } else {
          throw Exception('Estructura de respuesta inesperada');
        }
      } else {
        throw Exception('Estructura de respuesta inesperada');
      }
    } catch (error) {
      throw Exception('Error al obtener las zonas: $error');
    }
  }

}
