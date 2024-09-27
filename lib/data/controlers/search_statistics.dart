import 'package:habbit_mobil_flutter/data/models/search_statistics.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:intl/intl.dart';

class EstadisticasController {
  late EstadisticasBusquedas estadisticasBusquedas;

  EstadisticasController() {
    _initialize(); // Inicializa la estadística de búsqueda al crear una instancia del controlador
  }

  // Inicializa la estadística de búsqueda con datos predeterminados y el ID del cliente
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

  // Actualiza la ubicación preferida del usuario
  void actualizarUbicacion({
    required String ubicacion,
    required double latitud,
    required double longitud,
  }) {
    estadisticasBusquedas.ubicacionPreferida = ubicacion;
    estadisticasBusquedas.latitudPreferida = latitud;
    estadisticasBusquedas.longitudPreferida = longitud;
  }

  // Actualiza el rango de precios preferido del usuario
  void actualizarPrecio({
    required double min,
    required double max,
  }) {
    estadisticasBusquedas.precioMin = min;
    estadisticasBusquedas.precioMax = max;
  }

  // Actualiza la categoría preferida del usuario
  void actualizarCat({
    required int idCat,
  }) {
    estadisticasBusquedas.idCategoria = idCat;
  }

  // Actualiza la zona preferida del usuario
  void actualizarZone({
    required int idZona,
  }) {
    estadisticasBusquedas.idZona = idZona;
  }

  // Envía las estadísticas al servidor
  Future<void> enviarEstadisticas() async {
    try {
      // Actualiza la fecha de modificación antes de enviar los datos
      estadisticasBusquedas.fecha_modificacion =
          DateFormat('yyyy-MM-dd').format(DateTime.now());

      final json = estadisticasBusquedas.toJson();

      // Realiza una solicitud POST para enviar las estadísticas al servidor
      final response =
          await ApiService.sendData('/preferencias/save/', 'POST', json);

      if (response['success'] == true) {
        print('Estadísticas enviadas correctamente');
      } else {
        throw Exception(
            'Error al enviar las estadísticas ${response['message']}');
      }
    } catch (error) {
      throw Exception('Error al enviar las estadísticas: $error');
    }
  }

  // Obtiene las estadísticas de búsqueda del cliente desde el servidor
  Future<EstadisticasBusquedas> obtenerEstadisticas() async {
    try {
      final idCliente = await StorageService.getClientId();
      if (idCliente == null) {
        throw Exception('Hubo un error al encontrar el ID del cliente.');
      }

      // Realiza una solicitud GET para obtener las estadísticas del cliente
      final response = await ApiService.fetchData('/preferencias/$idCliente');

      if (response['success'] == true) {
        final nestedData = response['data'];

        if (nestedData is Map<String, dynamic>) {
          final listData = nestedData['data'];

          if (listData is List && listData.isNotEmpty) {
            final estadisticaData = listData[0];

            if (estadisticaData is Map<String, dynamic>) {
              final estadisticas =
                  EstadisticasBusquedas.fromJson(estadisticaData);
              return estadisticas;
            } else {
              throw Exception('El primer elemento de la lista no es un mapa.');
            }
          } else {
            throw Exception(
                'La clave "data" dentro del mapa no es una lista o está vacía.');
          }
        } else {
          throw Exception(
              'La clave "data" no es un mapa o no contiene la clave "data" como lista.');
        }
      } else {
        throw Exception(
            'Error al obtener las estadísticas: ${response['message']}');
      }
    } catch (error) {
      throw Exception('Error al obtener las estadísticas: $error');
    }
  }

  // Método para actualizar las preferencias del usuario
  Future<bool> updatePreferences(Map<String, dynamic>? formData) async {
    try {
      if (formData == null) {
        throw Exception('Los datos del formulario no pueden ser nulos.');
      }

      // Realiza una solicitud PUT para actualizar las preferencias
      final response =
          await ApiService.sendData('/preferencias/update', 'PUT', formData);

      return response['success'] == true;
    } catch (error) {
      print('Error al actualizar las preferencias: $error');
      throw Exception('Error al actualizar las preferencias: $error');
    }
  }
}
