// register model 
class RegisterResponse {
  final bool success;
  final int? status;
  final int? clientId;

  RegisterResponse({
    required this.success,
    this.status,
    this.clientId,
  });
  // convierte en json en un array normal 
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    final innerData = data['data'] as Map<String, dynamic>? ?? {};

    return RegisterResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      clientId: innerData['id_cliente'] as int?,
    );
  }
}
