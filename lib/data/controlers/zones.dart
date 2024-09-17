import 'package:habbit_mobil_flutter/data/models/zone.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class ZonesSerivce   {
  Future<List<Zone>> getZones() async {
    try {
      final response = await ApiService.fetchData('/zonas');

      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          return Zone.fromJsonList(data);
        } else {
          throw Exception('Unexpected API response');
        }
      } else {
        throw Exception('Unexpected API response');
      }
    } catch (error) {
      throw Exception('Error loading zones: $error');
    }
  }
}
