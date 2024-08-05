class ReadChatResponse {
  final bool success;
  final int? status;
  final int? messageId;
  final int? conversacionId;
  final String? mensajeAdmin;
  final String? mensajeCliente;
  final bool? readMessage;
  final String? time;

  ReadChatResponse({
    required this.success,
    this.status,
    this.messageId,
    this.conversacionId,
    this.mensajeAdmin,
    this.mensajeCliente,
    this.readMessage,
    this.time,
  });

  factory ReadChatResponse.fromJson(Map<String, dynamic> json) {
    return ReadChatResponse(
      success: json['success'] ?? false,
      status: json['status'] as int?,
      messageId: json['id_mensaje'] as int?,
      conversacionId: json['id_conversacion'] as int?,
      mensajeAdmin: json['mensaje_admin'] as String?,
      mensajeCliente: json['mensaje_cliente'] as String?,
      readMessage: json['leido_mensaje'] == 1,
      time: json['fecha_envio'] as String?,
    );
  }

  static List<ReadChatResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReadChatResponse.fromJson(json as Map<String, dynamic>)).toList();
  }
}
