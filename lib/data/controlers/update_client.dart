import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/data/models/update_client.dart';

class AuthService {
  // Método para manejar la actualización de datos del cliente
  Future<bool> updateClient(String id, String name, String email, String phone) async {
    try {
      // Crear el payload para enviar al servidor
      final data = updateInfo(id, name, email, phone);

      // Enviar los datos al servidor
      final response = await ApiService.sendData(
        '/clientes/updateDatos',
        'PUT',
        data,
      );

      if (response['success'] == true) {
        // Actualizar el nombre del cliente en el almacenamiento local
        StorageService.saveClientName(name);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  // Método para obtener la información del cliente
  Future<UpdateResponse> infoClient(String id) async {
    try {
      // Obtener los datos del cliente del servidor
      final response = await ApiService.fetchData("/clientes/$id");

      // Convertir la respuesta en un objeto UpdateResponse
      final get = UpdateResponse.fromJson(response);

      if (get.success) {
        return get;
      } else {
        throw Exception('Error en la respuesta del servidor: ${response['message']}');
      }
    } catch (error) {
      throw Exception('Error al cargar datos del cliente: $error');
    }
  }
}

// Crear JSON para enviar al servidor
Map<String, dynamic> updateInfo(String id, String name, String email, String phone) {
  return {
    'id_cliente': int.parse(id),
    'nombre_cliente': name,
    'email_cliente': email,
    'telefono_cliente': phone,
  };
}
