import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const int limiteToken = 30; // Límite de días para el token

  // Métodos para manejar el token
  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // Métodos para guardar el token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  // Métodos para manejar el ID del cliente
  static Future<String?> getClientId() async {
    return await _storage.read(key: 'client_id');
  }

  // Métodos para guardar el ID del cliente
  static Future<void> saveClientId(String clientId) async {
    await _storage.write(key: 'client_id', value: clientId);
  }

  // Métodos para manejar el nombre del cliente
  static Future<String?> getClientName() async {
    return await _storage.read(key: 'client_name');
  }

  // Métodos para guardar el nombre del cliente
  static Future<void> saveClientName(String clientName) async {
    await _storage.write(key: 'client_name', value: clientName);
  }

  // Método para manejar la fecha de credenciales guardadas
  static Future<String?> getCredentialsDate() async {
    return await _storage.read(key: 'credentials_date');
  }

  // Método para guardar la fecha de credenciales
  static Future<void> saveCredentialsDate(String date) async {
    await _storage.write(key: 'credentials_date', value: date);
  }

  // Método para limpiar todos los datos
  static Future<void> clear() async {
    await Future.wait([
      _storage.delete(key: 'token'),
      _storage.delete(key: 'client_id'),
      _storage.delete(key: 'client_name'),
      _storage.delete(key: 'credentials_date'),
    ]);
  }

  // Método para guardar token, ID del cliente, nombre del cliente y fecha con hora
  static Future<void> saveCredentials(
      String token, String clientId, String clientName) async {
    final String date = DateTime.now().toIso8601String(); // Obtener la fecha y hora actual en formato ISO 8601
    await Future.wait([
      _storage.write(key: 'token', value: token),
      _storage.write(key: 'client_id', value: clientId),
      _storage.write(key: 'client_name', value: clientName),
      _storage.write(key: 'credentials_date', value: date), // Guardar la fecha y hora
    ]);
  }

  // Método para validar si el usuario ya se registró y si el token ha vencido
  static Future<bool> isRegistered() async {
    try {
      final String? clientId = await _storage.read(key: 'client_id');
      final String? clientName = await _storage.read(key: 'client_name');
      final String? token = await _storage.read(key: 'token');
      final String? credentialsDate = await _storage.read(key: 'credentials_date');

      if (clientId != null && clientName != null && token != null && credentialsDate != null) {
        // Convertir la fecha almacenada en DateTime
        DateTime storedDate = DateTime.parse(credentialsDate);
        DateTime currentDate = DateTime.now();

        // Calcular la diferencia de días entre la fecha actual y la fecha de las credenciales
        int daysDifference = currentDate.difference(storedDate).inDays;

        // Verificar si la diferencia de días supera el límite
        if (daysDifference > limiteToken) {
          clear(); 
          return false; // El token ha vencido
        }

        return true; // El token sigue siendo válido
      } else {
        return false; // No está registrado o faltan datos
      }
    } catch (e) {
      return false; // En caso de error, no está registrado
    }
  }
}
