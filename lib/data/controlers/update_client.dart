import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/data/models/update_client.dart';

class AuthService {
  // Método para manejar el actualizar los datos del cliente 
Future<bool> updateClient(String id, String name, String email, String phone) async {
  try {
    final data = updateInfo(id, name, email, phone);
    final response = await ApiService.sendData(
      '/clientes/updateDatos',
      'PUT',
      data,
    );
    print('Respuesta del servidor: $response');
    
    if (response['success'] == true) {
      StorageService.saveClientName(name);
      return true;
    } else {
      final errorMessage = response['message'] ?? 'Unknown error';
      print('Error en la respuesta del servidor: $errorMessage');
      return false;
    }
  } catch (error) {
    print('Error al actualizar cliente: $error');
    return false;
  }
}




Future<UpdateResponse> infoClient(String id) async {
  try {
    final response = await ApiService.fetchData("/clientes/$id");
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

