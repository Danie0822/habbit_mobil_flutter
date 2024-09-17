import 'package:habbit_mobil_flutter/data/models/category.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class CategorysService {
  Future<List<Category>> getCategories() async {
    try {
      // Llamada a la API

      final response = await ApiService.fetchData('/categorias');

      // Print de la respuesta completa
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];

        if (data is List<dynamic>) {
          return Category.fromJsonList(data);
        } else {
          throw Exception('Unexpected API response');
        }
      } else {
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      // Print del error en caso de fallo

      throw Exception('Error loading Categories: $error');
    }
  }
}
