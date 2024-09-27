// login model 
class LoginResponse {
  // Success
  final bool success;
  // Status
  final int? status;
  // Token
  final String? token;
  // Client ID
  final int? clientId;
  // Client Name
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
    // extrae el objeto data
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    // extrae el objeto interno
    final innerData = data['data'] as Map<String, dynamic>? ?? {};
    // retorna el objeto
    return LoginResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      token: innerData['token'] as String?,
      clientId: innerData['id_cliente'] as int?,
      clientName: innerData['nombre_cliente'] as String?,
    );
  }
}
