import 'package:habbit_mobil_flutter/data/models/request_model.dart';
import 'package:habbit_mobil_flutter/data/models/send_chat.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class RequestService {
  // Método para cargar chats del cliente
  Future<List<RequestModel>> cargarRequest() async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();
      // Realiza una solicitud a la API para obtener las solicitudes del cliente
      final response =
          await ApiService.fetchData('/solicitudes/cliente/$idCliente');
      // Extrae los datos internos de la respuesta
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          // Convierte la lista de datos en una lista de solicitudes y la retorna
          return RequestModel.fromJsonList(data);
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

  Future<int> requestSave(titulo, descripcion, dirrecion, precio, ganancia,
      categoria, zona, exclusividad) async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();
      final data = {
        'id_cliente': idCliente,
        'titulo_solicitud': titulo,
        'descripcion_solicitud': descripcion,
        'direccion_propiedad': dirrecion,
        'precio_casa': precio,
        'ganancia_empresa': ganancia,
        'exclusividad_comercializacion': exclusividad,
        'estado_solicitud': 'Revisando',
        'id_categoria': categoria,
        'id_zona': zona,
      };
      // Enviar los datos al servidor
      final response = await ApiService.sendData(
        '/solicitudes/save',
        'POST',
        data,
      );
      // Convertir la respuesta en el modelo
      final loginResponse = SendChatResponse.fromJson(response);
      if (loginResponse.status == 200) {
        return 1;
      } else if (loginResponse.status == 401) {
        return 2;
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }

  Future<int> requestUpdate(
      titulo, descripcion, dirrecion, precio, ganancia, idSolicitud) async {
    try {
      // Data para enviar al servidor
      final data = {
        'id_solicitud': idSolicitud,
        'titulo_solicitud': titulo,
        'descripcion_solicitud': descripcion,
        'direccion_propiedad': dirrecion,
        'precio_casa': precio,
        'ganancia_empresa': ganancia
      };
      // Enviar los datos al servidor
      final response = await ApiService.sendData(
        '/solicitudes/update/cliente',
        'PUT',
        data,
      );
      // Convertir la respuesta en el modelo
        final loginResponse = SendChatResponse.fromJson(response);
      if (loginResponse.status == 200) {
        return 1;
        // 401 es un error de validaciones
      } else if (loginResponse.status == 401) {
        return 2;
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }

  Future<bool> requestDelete(idRequest) async {
    try {
      // Enviar la petición de eliminación al servidor
      final response = await ApiService.deleteData(
        '/solicitudes/delete/cliente/$idRequest',
      );
      // Convertir la respuesta en el modelo LoginResponse
      final loginResponse = SendChatResponse.fromJson(response);
      print(loginResponse.status);
      if (loginResponse.status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Error al eliminar la solicitud: $error');
    }
  }
}
