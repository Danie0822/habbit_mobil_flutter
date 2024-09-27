import 'package:habbit_mobil_flutter/data/models/recovery.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class RecoveryController {
  // Método para enviar un email de recuperación
  Future<int> sendEmail(int id) async {
    try {
      // Obtener el payload para enviar al servidor
      final data = createRecoveryPayload(id);
      
      // Enviar los datos al servidor
      final response = await ApiService.sendDataApiKey(
        '/recuperaciones/save',
        'POST',
        data,
      );

      bool success = response['success'];
      return success ? 1 : 0;
    } catch (error) {
      return 0; // Retorna 0 si ocurre un error
    }
  }

  // Método para manejar la solicitud de recuperación
  Future<int> sendRequest(int id, String codigo, String clave, String metodo) async {
    try {
      // Obtener el payload para enviar al servidor
      final data = createRecoveryJson(id, codigo, clave);
      
      // Enviar los datos al servidor
      final response = await ApiService.sendDataApiKey(
        "/recuperaciones/$metodo",
        'POST',
        data,
      );

      bool success = response['success'];
      final RecoveryResponse recovery = RecoveryResponse.fromJson(response);

      // Retornar la existencia del resultado según la respuesta del servidor
      return success ? recovery.existe! : recovery.existe!;
    } catch (error) {
      return 0; // Retorna 0 si ocurre un error
    }
  }
}

// Crear JSON para enviar al servidor para solicitar un email de recuperación
Map<String, dynamic> createRecoveryPayload(int id) {
  return {
    'p_id_usuario': id,
    'p_es_administrador': 0,
  };
}

// Crear JSON para enviar al servidor para el proceso de recuperación
Map<String, dynamic> createRecoveryJson(int id, String codigo, String clave) {
  return {
    'p_id_usuario': id,
    'p_codigo_recuperacion': codigo,
    'p_nueva_clave': clave,
    'p_es_administrador': 0,
  };
}
