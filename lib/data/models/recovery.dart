// Recovery model 
class RecoveryResponse {
  final bool success;
  final int? status;
  final int? existe;

  RecoveryResponse({
    required this.success,
    this.status,
    this.existe
  });
  // convierte en json en un array normal 
  factory RecoveryResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    final innerData = data['data'] as Map<String, dynamic>? ?? {};

    return RecoveryResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      existe: innerData['existe'] as int?,
    );
  }
}
