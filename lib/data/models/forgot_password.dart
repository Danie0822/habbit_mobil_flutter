// login model 
class ForgotPasswordResponse {
  final bool success;
  final int? status;
  final int? clientId;

  ForgotPasswordResponse({
    required this.success,
    this.status,
    this.clientId,
  });
  // convierte en json en un array normal 
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    final innerData = data['data'] as Map<String, dynamic>? ?? {};

    return ForgotPasswordResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      clientId: innerData['id_usuario'] as int?,
    );
  }
}
