import 'package:habbit_mobil_flutter/data/models/recovery.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';

class RecoveryController {
  // Método para manejar el login
  Future<int> sendEmail(int id) async {
    try {
      // Obtener el payload para enviar al servidor
      final data = createRecoveryPayload(id);
      // Enviar los datos de login al servidor
      final response = await ApiService.sendDataApiKey(
        '/recuperaciones/save',
        'POST',
        data,
      );
      bool success = response['success'];
      if (success) {
        return 1;
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }
}
// Crear JSON para enviar al servidor
 Map<String, dynamic> createRecoveryPayload(int id) {
    return {
      'p_id_usuario': id,
      'p_es_administrador': 0,
    };
  }