class ReadChatResponse {
  final int id;
  final String? mensajeAdmin;
  final String? mensajeCliente;
  bool? readMessage;
  final String? time;

  ReadChatResponse({
    required this.id,
    this.mensajeAdmin,
    this.mensajeCliente,
    this.readMessage,
    this.time,
  });

  factory ReadChatResponse.fromJson(Map<String, dynamic> json) {
    return ReadChatResponse(
      id: json['id_mensaje'] ?? 0,  // Valor predeterminado si es nulo
      mensajeAdmin: json['mensaje_admin'],
      mensajeCliente: json['mensaje_cliente'],
      readMessage: json['leido_mensaje'] == 1 ? true : false,  // Conversión a booleano
      time: json['fecha_envio'],
    );
  }

  static List<ReadChatResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReadChatResponse.fromJson(json)).toList();
  }

  void updateReadStatus(bool readStatus) {
    readMessage = readStatus;
  }
}
