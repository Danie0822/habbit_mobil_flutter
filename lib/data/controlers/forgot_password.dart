import 'package:habbit_mobil_flutter/data/models/forgot_password.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class ForgotPasswordController {
  // Método para manejar el login
  Future<int> validateEmail(String email) async {
    try {
      final loginPayload = {
        'correo': email,
        'es_admin': 0,
      };
      // Enviar los datos de login al servidor
      final response = await ApiService.sendDataApiKey(
        '/recuperaciones/correo',
        'POST',
        loginPayload,
      );
      // Convertir la respuesta en el modelo LoginResponse
      final loginResponse = ForgotPasswordResponse.fromJson(response);
      if (loginResponse.success) {
        return loginResponse.clientId ?? 0;
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }
}
