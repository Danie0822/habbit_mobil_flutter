import 'package:habbit_mobil_flutter/data/models/message.dart';
import 'package:habbit_mobil_flutter/data/models/create_chat.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class MessageService {
  // Método para cargar chats del cliente
  Future<List<MessageResponse>> cargarChats() async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();
      // Realiza una solicitud a la API para obtener los mensajes del cliente
      final response =
          await ApiService.fetchData('/mensaje/cliente/$idCliente');

      // Extrae los datos internos de la respuesta
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          // Convierte la lista de datos en una lista de MessageResponse y la retorna
          return MessageResponse.fromJsonList(data);
        } else {
          // Lanza una excepción si la respuesta no es la esperada
          throw Exception('Respuesta inesperada de la API');
        }
      } else {
        // Lanza una excepción si la respuesta no es la esperada
        throw Exception('Respuesta inesperada de la API');
      }
    } catch (error) {
      // Lanza una excepción en caso de error
      throw Exception('Error al cargar chats: $error');
    }
  }

  // Método para cargar chats del cliente
  Future<MessageCreateResponse> crearChat(int idPropiedad) async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();

      // Define el payload del mensaje
      final body = {'id_cliente': idCliente, 'id_propiedad': idPropiedad};

      // Envía los datos a la API
      final response = await ApiService.sendData(
        '/mensaje/save',
        'POST',
        body,
      );
        // Aquí parseamos el response y creamos una instancia del modelo
      final messageCreateResponse = MessageCreateResponse.fromJson(response['data']);
      return messageCreateResponse;
    } catch (error) {
      // Lanza una excepción en caso de error
      throw Exception('Error al cargar chats: $error');
    }
  }
}
