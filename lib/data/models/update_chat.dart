// login model 
class UpdateChatResponse {
  final bool success;
  final int? status;

  UpdateChatResponse({
    required this.success,
    this.status,
  });
  // convierte en json en un array normal 
  factory UpdateChatResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {}; 

    return UpdateChatResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?
    );
  }
}
