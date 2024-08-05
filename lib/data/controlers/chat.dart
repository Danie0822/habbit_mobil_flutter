import 'package:habbit_mobil_flutter/data/models/update_chat.dart';
import 'package:habbit_mobil_flutter/data/models/send_chat.dart';
import 'package:habbit_mobil_flutter/data/models/read_chat.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class ChatService {
  // Método para obtener los mensajes de un cliente
  Future<List<ReadChatResponse>> getClientMessages() async {
    try {
      final idCliente = await StorageService.getClientId();
      final response = await ApiService.fetchData('/cliente/$idCliente');
      final List<dynamic> data = response['data'] as List<dynamic>;
      return ReadChatResponse.fromJsonList(data);
    } catch (error) {
      return [];
    }
  }

  // Método para enviar un mensaje
  Future<bool> sendMessage(int conversationId, String adminMessage) async {
    try {
      final messagePayload = {
        'id_conversacion': conversationId,
        'mensaje_admin': adminMessage,
        'leido_mensaje': false,
      };
      final response = await ApiService.sendData(
        '/chat/cliente',
        'POST',
        messagePayload,
      );
      final sendChatResponse = SendChatResponse.fromJson(response);
      return sendChatResponse.success;
    } catch (error) {
      return false;
    }
  }

  // Método para actualizar el estado de lectura de un mensaje
  Future<bool> updateMessageReadStatus(int conversationId) async {
    try {
      final updatePayload = {
        'id_conversacion': conversationId,
        'tipo_mensaje': 'admin',
      };
      final response = await ApiService.sendData(
        '/actualizar/cliente',
        'POST',
        updatePayload,
      );
      final updateChatResponse = UpdateChatResponse.fromJson(response);
      return updateChatResponse.success;
    } catch (error) {
      return false;
    }
  }
}
