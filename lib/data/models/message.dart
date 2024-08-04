// Mensaje model 
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
  });
  // convierte en json en un array normal 
  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {}; 
    final innerData = data['data'] as Map<String, dynamic>? ?? {};

    return MessageResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      conversacionId: innerData['id_conversacion'] as int?,
      lastMessage: innerData['ultimo_mensaje'] as String?,
      readMessage: innerData['leido_mensaje'] as bool?,
      propertyTitle: innerData['titulo_propiedad'] as String?,
      imageUrl: innerData['imagen_url'] as String?,
      adminName: innerData['nombre_administrador'] as String?,
      senderType: innerData['tipo_remitente'] as String?,
    );
  }
}
