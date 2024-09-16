import 'package:habbit_mobil_flutter/data/models/category.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class CategorysService {
  Future<List<Category>> getCategories() async {
    try {
      // Llamada a la API
      print("Fetching categories from API...");
      final response = await ApiService.fetchData('/categorias');

      // Print de la respuesta completa
      print("API Response: $response");

      final innerData = response['data'];

      // Print del 'innerData' después de acceder a 'data'
      print("Inner Data: $innerData");

      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        
        // Print del 'data' para ver qué se está devolviendo
        print("Categories Data: $data");

        if (data is List<dynamic>) {
          // Print cuando se parsea la lista
          print("Parsing categories list...");
          return Category.fromJsonList(data);
        } else {
          throw Exception('Unexpected API response');
        }
      } else {
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      // Print del error en caso de fallo
      print("Error in getCategories: $error");
      throw Exception('Error loading Categories: $error');
    }
  }
}
