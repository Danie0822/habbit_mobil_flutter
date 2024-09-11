// ignore_for_file: avoid_print

import 'package:habbit_mobil_flutter/data/models/update_chat.dart';
import 'package:habbit_mobil_flutter/data/models/send_chat.dart';
import 'package:habbit_mobil_flutter/data/models/read_chat.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class ChatService {
  // Método para obtener los mensajes de una conversación específica del cliente
  Future<List<ReadChatResponse>> getClientMessages(int idConversacion) async {
    try {
      final response = await ApiService.fetchData('/mensaje/conversation/cliente/$idConversacion');
      // Extrae la lista de datos de la respuesta
      final List<dynamic> data = response['data']['data'] as List<dynamic>;

      // Convierte la lista de datos en una lista de ReadChatResponse y la retorna
      return ReadChatResponse.fromJsonList(data);
    } catch (error) {
      // Imprime el error y retorna una lista vacía en caso de excepción
      print('Error en getClientMessages: $error');
      return [];
    }
  }

  // Método para enviar un mensaje en una conversación específica
  Future<bool> sendMessage(int conversationId, String clientMessage) async {
    try {
      // Define el payload del mensaje
      final messagePayload = {
        'id_conversacion': conversationId,
        'mensaje_cliente': clientMessage,
        'leido_mensaje': false,
      };

      // Envía los datos a la API
      final response = await ApiService.sendData(
        '/mensaje/chat/cliente',
        'POST',
        messagePayload,
      );

      // Convierte la respuesta en un objeto SendChatResponse y verifica el éxito
      final sendChatResponse = SendChatResponse.fromJson(response);
      return sendChatResponse.success;
    } catch (error) {
      // Retorna false en caso de excepción
      print('Error en sendMessage: $error');
      return false;
    }
  }

  // Método para actualizar el estado de lectura de los mensajes en una conversación específica
  Future<bool> updateMessageReadStatus(int conversationId) async {
    try {
      // Define el payload para actualizar el estado de lectura
      final updatePayload = {
        'id_conversacion': conversationId,
        'tipo_mensaje': 'admin',
      };

      // Envía los datos a la API
      final response = await ApiService.sendData(
        '/mensaje/actualizar/cliente',
        'POST',
        updatePayload,
      );

      // Convierte la respuesta en un objeto UpdateChatResponse y verifica el éxito
      final updateChatResponse = UpdateChatResponse.fromJson(response);
      return updateChatResponse.success;
    } catch (error) {
      // Retorna false en caso de excepción
      print('Error en updateMessageReadStatus: $error');
      return false;
    }
  }
}
