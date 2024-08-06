// Modelo para la respuesta de enviar un mensaje
class SendChatResponse {
  final bool success; // Indica si la operación fue exitosa
  final int? status; // Estado adicional de la respuesta (opcional)

  // Constructor para inicializar los atributos de la clase
  SendChatResponse({
    required this.success,
    this.status,
  });

  // Método de fábrica para crear una instancia de SendChatResponse a partir de un JSON
  factory SendChatResponse.fromJson(Map<String, dynamic> json) {
    // Extrae el campo 'data' del JSON, usa un mapa vacío si no está presente
    final data = json['data'] as Map<String, dynamic>? ?? {}; 

    return SendChatResponse(
      // Extrae 'success' del JSON, usa 'false' si no está presente
      success: json['success'] ?? false,
      // Extrae 'status' del campo 'data', usa null si no está presente
      status: data['status'] as int?,
    );
  }
}
