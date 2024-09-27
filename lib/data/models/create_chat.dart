class MessageCreateResponse {
  // Atributos de la clase
  final bool success;
  final int? status;
  final String? message;
  final String? error;
  final int? idConversacion;

  // Constructor para inicializar los atributos de la clase
  MessageCreateResponse({
    required this.success,
    this.status,
    this.message,
    this.error,
    this.idConversacion,
  });

  // Método de fábrica para crear una instancia de MessageCreateResponse a partir de un JSON
  factory MessageCreateResponse.fromJson(Map<String, dynamic> json) {
    // Verifica si el campo 'data' es un mapa
    final data = json['data'];
    int? idConversacion;

    // Si 'data' es un mapa, intenta extraer 'id_conversacion'
    if (data is Map<String, dynamic>) {
      idConversacion = data['id_conversacion'] as int?;
    } else if (data is int) {
      // Si 'data' es directamente un int, lo asigna a 'idConversacion'
      idConversacion = data;
    }

    return MessageCreateResponse(
      success: json['success'] ?? false,
      status: json['status'] as int?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      idConversacion: idConversacion,
    );
  }

  // Método estático para crear una lista de instancias de MessageCreateResponse a partir de una lista de JSON
  static List<MessageCreateResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => MessageCreateResponse.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
