import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
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

  // Método para limpiar todos los datos
  static Future<void> clear() async {
    await Future.wait([
      _storage.delete(key: 'token'),
      _storage.delete(key: 'client_id'),
      _storage.delete(key: 'client_name'),
    ]);
  }

  // Método para guardar token, ID del cliente y nombre del cliente
  static Future<void> saveCredentials(
      String token, String clientId, String clientName) async {
    await Future.wait([
      _storage.write(key: 'token', value: token),
      _storage.write(key: 'client_id', value: clientId),
      _storage.write(key: 'client_name', value: clientName),
    ]);
  }
}
