class MessageResponse {
  final bool success;
  final int? status;
  final int? conversacionId;
  final String? lastMessage;
  final bool? readMessage;
  final String? propertyTitle;
  final String? imageUrl;
  final String? adminName;
  final String? senderType;
  final String? time;

  MessageResponse({
    required this.success,
    this.status,
    this.conversacionId,
    this.lastMessage,
    this.readMessage,
    this.propertyTitle,
    this.imageUrl,
    this.adminName,
    this.senderType,
    this.time,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      success: json['success'] ?? false,
      status: json['status'] as int?,
      conversacionId: json['id_conversacion'] as int?,
      lastMessage: json['ultimo_mensaje'] as String?,
      readMessage: json['leido_mensaje'] == 1,
      propertyTitle: json['titulo_propiedad'] as String?,
      imageUrl: json['imagen_url'] as String?,
      adminName: json['nombre_administrador'] as String?,
      senderType: json['tipo_remitente'] as String?,
      time: json['fecha_envio'] as String?,
    );
  }

  static List<MessageResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MessageResponse.fromJson(json as Map<String, dynamic>)).toList();
  }
}
