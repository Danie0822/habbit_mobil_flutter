import 'package:habbit_mobil_flutter/data/models/login.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/utils/constants/crypto.dart';

class AuthService {
  // Método para manejar el login
  Future<bool> login(String email, String password) async {
    try {
      final hashedPassword = hashPassword(password);
      final loginPayload = {
        'correo': email,
        'clave': hashedPassword,
      };
      // Enviar los datos de login al servidor
      final response = await ApiService.sendDataApiKey(
        '/login/cliente',
        'POST',
        loginPayload,
      );
      // Convertir la respuesta en el modelo LoginResponse
      final loginResponse = LoginResponse.fromJson(response);
      if (loginResponse.success) {
          // Guardar token, ID del cliente y nombre del cliente
          await StorageService.saveCredentials(
            loginResponse.token!,
            loginResponse.clientId!.toString(),
            loginResponse.clientName!,
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
