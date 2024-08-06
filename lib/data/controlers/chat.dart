import 'package:habbit_mobil_flutter/data/models/update_chat.dart';
import 'package:habbit_mobil_flutter/data/models/send_chat.dart';
import 'package:habbit_mobil_flutter/data/models/read_chat.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class ChatService {
  Future<List<ReadChatResponse>> getClientMessages(int idConversacion) async {
    try {
      final response = await ApiService.fetchData('/mensaje/conversation/cliente/$idConversacion');
      print('idConversacion: $idConversacion');
      print(response);

      final List<dynamic> data = response['data']['data'] as List<dynamic>;

      return ReadChatResponse.fromJsonList(data);
    } catch (error) {
      print('Error en getClientMessages: $error');
      return [];
    }
  }

  Future<bool> sendMessage(int conversationId, String clientMessage) async {
    try {
      final messagePayload = {
        'id_conversacion': conversationId,
        'mensaje_cliente': clientMessage,
        'leido_mensaje': false,
      };
      final response = await ApiService.sendData(
        '/mensaje/chat/cliente',
        'POST',
        messagePayload,
      );
      final sendChatResponse = SendChatResponse.fromJson(response);
      return sendChatResponse.success;
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateMessageReadStatus(int conversationId) async {
    try {
      final updatePayload = {
        'id_conversacion': conversationId,
        'tipo_mensaje': 'admin',
      };
      final response = await ApiService.sendData(
        '/mensaje/actualizar/cliente',
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
