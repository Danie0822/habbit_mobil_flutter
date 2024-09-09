import 'package:habbit_mobil_flutter/data/models/home_screen.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class MessageService {
  // Método para cargar chats del cliente
  Future<List<HomeScreenResponse>> cargarDatos() async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();

      // Define el payload del mensaje
      final formData = {
        'id_cliente': idCliente
      };

      // Envía los datos a la API
      final response = await ApiService.sendData(
        '/dashboard/movil/cliente',
        'POST',
        formData,
      );
      // Extrae los datos internos de la respuesta
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          // Convierte la lista de datos en una lista de MessageResponse y la retorna
          return HomeScreenResponse.fromJsonList(data);
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
}
