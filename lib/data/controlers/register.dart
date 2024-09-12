import 'package:habbit_mobil_flutter/data/models/register.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/utils/constants/crypto.dart';

class AuthService {
  // Método para manejar el registrar
  Future<bool> register(String name, String email, String phone,String password) async {
    try {
      final hashedPassword = hashPassword(password);
      final registerPayload = {
        'nombre_cliente': name,
        'email_cliente': email,
        'telefono_cliente': phone,
        'clave_cliente': hashedPassword,
      };
      // Enviar los datos al servidor
      final response = await ApiService.sendDataApiKey(
        '/clientes/save',
        'POST',
        registerPayload,
      );
      // Convertir la respuesta en el modelo 
      final registerResponse = RegisterResponse.fromJson(response);
      if (registerResponse.success) {
          // Guardar token, ID del cliente
          await StorageService.saveClientId(
            registerResponse.clientId!.toString(),
          );
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}