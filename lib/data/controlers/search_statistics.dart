import 'package:habbit_mobil_flutter/data/models/search_statistics.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class EstadisticasController {
  late EstadisticasBusquedas estadisticasBusquedas;

  EstadisticasController();

  Future<void> _initialize() async {
    final clientId = await StorageService.getClientId();
    estadisticasBusquedas = EstadisticasBusquedas(
      idCliente: clientId ?? '', // Usa un valor predeterminado o maneja el caso en el que clientId es null
      ubicacionPreferida: '',
      latitudPreferida: 0.0,
      longitudPreferida: 0.0,
      precioMin: 0.0,
      precioMax: 0.0,
      idCategoria: 0, // Asegúrate de que estos valores sean válidos o se inicialicen correctamente
      idZona: 0,
    );
  }

  void actualizarUbicacion({
    required String ubicacion,
    required double latitud,
    required double longitud,
  }) {
    estadisticasBusquedas.ubicacionPreferida = ubicacion;
    estadisticasBusquedas.latitudPreferida = latitud;
    estadisticasBusquedas.longitudPreferida = longitud;
    print('Ubicación actualizada: $ubicacion, Latitud: $latitud, Longitud: $longitud');
  }

  void actualizarPrecio({
    required double min,
    required double max,
  }) {
    estadisticasBusquedas.precioMin = min;
    estadisticasBusquedas.precioMax = max;
    print('precio min: $min, precio max: $max');
  }

  void actualizarCat({
    required int idCat,
  }) {
    estadisticasBusquedas.idCategoria = idCat;
    print(idCat);
  }

  void actualizarZone({
    required int idZona,
  }) {
    estadisticasBusquedas.idZona = idZona;
    print(idZona);
  }

  Future<void> enviarEstadisticas() async {
  try {
    // Asegúrate de que la inicialización esté completa
    if (estadisticasBusquedas == null) {
      await _initialize();
    }

    final json = estadisticasBusquedas.toJson();
    print('Datos enviados: $json'); // Verifica que los datos sean correctos

    final response = await ApiService.sendData('/preferencias/save/', 'POST', json);

    if (response['success'] == true) {
      print('Estadísticas enviadas correctamente');
    } else {
      throw Exception('Error al enviar las estadísticas: ${response['message']}');
    }
  } catch (error) {
    throw Exception('Error al enviar las estadísticas: $error');
  }
}

}
