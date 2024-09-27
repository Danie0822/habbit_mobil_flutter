// login model 
class UpdateChatResponse {
  // Success
  final bool success;
  // Status
  final int? status;
  // Constructor
  UpdateChatResponse({
    required this.success,
    this.status,
  });
  // convierte en json en un array normal 
  factory UpdateChatResponse.fromJson(Map<String, dynamic> json) {
    // extrae el objeto data
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    // retorna el objeto
    return UpdateChatResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?
    );
  }
}
