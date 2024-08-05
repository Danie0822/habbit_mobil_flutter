// login model 
class SendChatResponse {
  final bool success;
  final int? status;

  SendChatResponse({
    required this.success,
    this.status,
  });
  // convierte en json en un array normal 
  factory SendChatResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {}; 

    return SendChatResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?
    );
  }
}
