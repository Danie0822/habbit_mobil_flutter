import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/data/services/api_service.dart';


class PropertiesDetailService {

  Future<List<PropertiesResponse>> getPropertiesDetails(int idPropiedad) async {
    try {
  
       final response = await ApiService.fetchData('/propiedades/movil/$idPropiedad');
      

       final innerData = response['data'];
       if(innerData is Map<String, dynamic>){
         final data = innerData['data'];
         print(data);
         if(data is List<dynamic>){
           
           return PropertiesResponse.fromJsonList(data);
          
         } else {
           throw Exception('Unexpected API response');
           
         }
       } else {
         throw Exception('Unexpected API response');
       }
    }catch (error){
      throw Exception('Error loading properties: $error');
    }

  }
  
}

