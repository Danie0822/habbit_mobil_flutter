// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:habbit_mobil_flutter/data/models/message.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class MessageService {
  Future<List<MessageResponse>> cargarChats() async {
    try {
      final idCliente = await StorageService.getClientId(); // Asegúrate de que esto sea un Future.
      final response = await ApiService.fetchData('/mensaje/' + idCliente.toString());

      // Convertir la respuesta en el modelo MessageResponse
      final mensajeResponse = MessageResponse.fromJson(response);

      if (mensajeResponse.success) {
        return [mensajeResponse]; // Devuelve una lista con el mensajeResponse
      } else {
        return []; // Devuelve una lista vacía si no hay éxito
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error cargando chats: $error'); // Manejo de errores
      return []; // Devuelve una lista vacía en caso de error
    }
  }
}