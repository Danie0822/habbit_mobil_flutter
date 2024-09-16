import 'package:habbit_mobil_flutter/data/models/blogs_main.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class BlogsService {
  Future<List<BlogsResponse>> getBlogs() async {
    try {
      final response = await ApiService.fetchData('/blogs/');

      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          return BlogsResponse.fromJsonList(data);
        } else {
          throw Exception('Unexpected API response');
        }
      } else {
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      throw Exception('Error loading: $error');
    }
  }
}
