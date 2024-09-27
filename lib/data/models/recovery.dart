// Recovery model 
class RecoveryResponse {
  // Success
  final bool success;
  // Status
  final int? status;
  // Existe
  final int? existe;
  // Constructor
  RecoveryResponse({
    required this.success,
    this.status,
    this.existe
  });
  // convierte en json en un array normal 
  factory RecoveryResponse.fromJson(Map<String, dynamic> json) {
    // extrae el objeto data
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    // extrae el objeto interno
    final innerData = data['data'] as Map<String, dynamic>? ?? {};
    // retorna el objeto
    return RecoveryResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      existe: innerData['existe'] as int?,
    );
  }
}
