import 'package:habbit_mobil_flutter/data/models/send_chat.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class blogsRating {
  // Método para manejar el registrar
  Future<int> ratingSend(int idBlog, int calificacion) async {
    try {
      // Obtiene el ID del cliente desde el servicio de almacenamiento
      final idCliente = await StorageService.getClientId();
      final registerPayload = {
        'id_blog': idBlog,
        'id_cliente': idCliente,
        'calificacion': calificacion,
      };
      // Enviar los datos al servidor
      final response = await ApiService.sendData(
        '/blogs/valoracion',
        'POST',
        registerPayload,
      );
      // Convertir la respuesta en el modelo
      final ratingRepost = SendChatResponse.fromJson(response);
      if (ratingRepost.status == 200) {
        return 1;
      } else if (ratingRepost.status == 400) {
        return 2;
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }
}
