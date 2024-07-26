// login model 
class LoginResponse {
  final bool success;
  final int? status;
  final String? token;
  final int? clientId;
  final String? clientName;

  LoginResponse({
    required this.success,
    this.status,
    this.token,
    this.clientId,
    this.clientName,
  });
  // convierte en json en un array normal 
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    final innerData = data['data'] as Map<String, dynamic>? ?? {};

    return LoginResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      token: innerData['token'] as String?,
      clientId: innerData['id_cliente'] as int?,
      clientName: innerData['nombre_cliente'] as String?,
    );
  }
}
