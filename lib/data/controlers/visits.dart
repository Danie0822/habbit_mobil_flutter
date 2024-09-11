
import 'package:habbit_mobil_flutter/data/services/api_service.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/data/models/visits_model.dart';

class VisitControler {
  //Creamos un metodo para cargar eventos agendados  
  Future<List<VisitModel>> cargarVisitas() async{
    try{
      //Obtiene el id del cliente desde el almacenamiento
      final idCliente = await StorageService.getClientId();

      //Realiza la peticion al servidor para traer todos los datos
      final response = await ApiService.fetchData('/visitas/clientes/$idCliente');
      final innerData = response['data'];
      if (innerData is Map<String, dynamic>) {
        final data = innerData['data'];
        if (data is List<dynamic>) {
          // Convierte la lista de datos en una lista de solicitudes y la retorna
          return VisitModel.fromJsonList(data);
        } else {
          // Lanza una excepción si la respuesta no es la esperada
          throw Exception('Respuesta inesperada de la API');
        }
      } else {
        // Lanza una excepción si la respuesta no es la esperada
        throw Exception('Respuesta inesperada de la API');
      }
      

    }catch(error){
      throw Exception('Error al cargar visitas: $error');

    }
  }
}