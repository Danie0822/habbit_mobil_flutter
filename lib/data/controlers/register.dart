import 'package:habbit_mobil_flutter/data/models/register.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/utils/constants/crypto.dart';

// Clase AuthService para manejar la autenticación del usuario
class AuthService {
  // Método para manejar el registro de un usuario
  Future<bool> register(
      String name, String email, String phone, String password) async {
    try {
      // Encripta la contraseña usando una función de hashing
      final hashedPassword = hashPassword(password);

      // Define los datos de registro
      final registerPayload = {
        'nombre_cliente': name,
        'email_cliente': email,
        'telefono_cliente': phone,
        'clave_cliente': hashedPassword,
      };

      // Envía los datos al servidor mediante una solicitud POST
      final response = await ApiService.sendDataApiKey(
        '/clientes/save',
        'POST',
        registerPayload,
      );

      // Convierte la respuesta en el modelo RegisterResponse
      final registerResponse = RegisterResponse.fromJson(response);

      if (registerResponse.success) {
        // Guarda el ID del cliente en el almacenamiento local
        await StorageService.saveClientId(registerResponse.clientId!.toString());
        return true; // Retorna true si el registro fue exitoso
      } else {
        return false; // Retorna false si hubo un error durante el registro
      }
    } catch (error) {
      return false; // En caso de error, retorna false
    }
  }
}
