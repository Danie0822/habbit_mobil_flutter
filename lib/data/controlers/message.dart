import 'package:habbit_mobil_flutter/data/models/message.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class MessageService {
  Future<List<MessageResponse>> cargarChats() async {
    try {
      final idCliente = await StorageService.getClientId();
      final response =
          await ApiService.fetchData('/mensaje/cliente/$idCliente');

      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          return MessageResponse.fromJsonList(data);
        }
        else{
          throw Exception('Respuesta inesperada de la API');
        }
      }
      else{
        throw Exception('Respuesta inesperada de la API');
      }
    } catch (error) {
      throw Exception('$error');
    }
  }
}
