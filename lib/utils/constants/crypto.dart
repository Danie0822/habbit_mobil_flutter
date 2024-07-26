import 'package:crypto/crypto.dart';
import 'dart:convert';
String hashPassword(String password) {
  final bytes = utf8.encode(password); // Convertir la contraseña a bytes
  final digest = sha256.convert(bytes); // Aplicar SHA-256
  return digest.toString(); // Convertir el digest a string
}
