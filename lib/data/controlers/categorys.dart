import 'package:habbit_mobil_flutter/data/models/category.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class CategorysService {
  Future<List<Category>> getCategories() async {
    try {
      // Llamada a la API
      final response = await ApiService.fetchData('/categorias');
      // Obtiene los datos principales de la respuesta
      final innerData = response['data'];

      // Verifica si los datos internos tienen el formato esperado (un mapa)
      if (innerData is Map<String, dynamic>) {
        // Extrae la lista de categooria de los datos internos
        final data = innerData['data'];
        // Verifica si la lista tiene el formato esperado (una lista dinámica)
        if (data is List<dynamic>) {
          // Convierte la lista dinámica a una lista
          return Category.fromJsonList(data);
        } else {
          throw Exception('Unexpected API response');
        }
      } else {
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      throw Exception('Error loading Categories: $error');
    }
  }
}
