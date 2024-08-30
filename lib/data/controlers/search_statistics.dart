import 'package:habbit_mobil_flutter/data/models/search_statistics.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class EstadisticasController {
  late EstadisticasBusquedas estadisticasBusquedas;

  EstadisticasController(){
    _initialize();
  }

  Future<void> _initialize() async {
    final clientId = await StorageService.getClientId();
    estadisticasBusquedas = EstadisticasBusquedas(
      idCliente: clientId ?? '', // Usa un valor predeterminado o maneja el caso en el que clientId es null
      ubicacionPreferida: '',
      latitudPreferida: 0.0,
      longitudPreferida: 0.0,
      precioMin: 0.0,
      precioMax: 0.0,
      fecha_modificacion: '',
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
    //print('Ubicación actualizada: $ubicacion, Latitud: $latitud, Longitud: $longitud');
  }

  void actualizarPrecio({
    required double min,
    required double max,
  }) {
    estadisticasBusquedas.precioMin = min;
    estadisticasBusquedas.precioMax = max;
    //print('precio min: $min, precio max: $max');
  }

  void actualizarCat({
    required int idCat,
  }) {
    estadisticasBusquedas.idCategoria = idCat;
    //print(idCat);
  }

  void actualizarZone({
    required int idZona,
  }) {
    estadisticasBusquedas.idZona = idZona;
    //print(idZona);
  }

  Future<void> enviarEstadisticas() async {
  try {
    final json = estadisticasBusquedas.toJson();
    //print('Datos enviados: $json'); 

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

Future<void> obtenerEstadisticas() async {
  try {
    final idCliente = await StorageService.getClientId();
    if (idCliente == null) throw Exception('Hubo un error al encontrar el ID del cliente.');

    final response = await ApiService.fetchData('/preferencias/$idCliente');

    if (response['success'] == true) {
      final data = response['data'];
      
      if (data is Map<String, dynamic>) {

        // Utiliza el método fromJson de EstadisticasBusquedas para deserializar
        estadisticasBusquedas = EstadisticasBusquedas.fromJson(data);

        // Ahora tienes los datos cargados en estadisticasBusquedas y puedes usarlos en tus pantallas
        print('Estadísticas obtenidas correctamente: ${estadisticasBusquedas.toJson()}');
      } else {
        throw Exception('La respuesta de la API no tiene el formato esperado.');
      }
    } else {
      throw Exception('Error al obtener las estadísticas: ${response['message']}');
    }
  } catch (error) {
    throw Exception('Error al obtener las estadísticas: $error');
  }
}

}
