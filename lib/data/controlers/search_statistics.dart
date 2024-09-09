import 'package:habbit_mobil_flutter/data/models/search_statistics.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:intl/intl.dart'; 

class EstadisticasController {
  late EstadisticasBusquedas estadisticasBusquedas;

  EstadisticasController() {
    _initialize();
  }

  Future<void> _initialize() async {
    final clientId = await StorageService.getClientId();
    estadisticasBusquedas = EstadisticasBusquedas(
      idCliente: clientId ?? '',
      ubicacionPreferida: '',
      latitudPreferida: 0.0,
      longitudPreferida: 0.0,
      precioMin: 0.0,
      precioMax: 0.0,
      fecha_modificacion: '',
      idCategoria: 0,
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
  }

  void actualizarPrecio({
    required double min,
    required double max,
  }) {
    estadisticasBusquedas.precioMin = min;
    estadisticasBusquedas.precioMax = max;
  }

  void actualizarCat({
    required int idCat,
  }) {
    estadisticasBusquedas.idCategoria = idCat;
  }

  void actualizarZone({
    required int idZona,
  }) {
    estadisticasBusquedas.idZona = idZona;
  }

  Future<void> enviarEstadisticas() async {
    try {
      estadisticasBusquedas.fecha_modificacion = DateFormat('yyyy-MM-dd').format(DateTime.now());
      
      final json = estadisticasBusquedas.toJson();

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
          estadisticasBusquedas = EstadisticasBusquedas.fromJson(data);
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
