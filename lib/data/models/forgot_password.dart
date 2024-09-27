// Forgot password model 
class ForgotPasswordResponse {
  // Success
  final bool success;
  // Status
  final int? status;
  // Client ID
  final int? clientId;

  ForgotPasswordResponse({
    required this.success,
    this.status,
    this.clientId,
  });
  // convierte en json en un array normal 
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    // extrae el objeto data
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    // extrae el objeto interno
    final innerData = data['data'] as Map<String, dynamic>? ?? {};
    // retorna el objeto
    return ForgotPasswordResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      clientId: innerData['id_usuario'] as int?,
    );
  }
}
