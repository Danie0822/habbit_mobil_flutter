class ReadChatResponse {
  // Atributos
  final int id;
  final String? mensajeAdmin;
  final String? mensajeCliente;
  bool? readMessage;
  final String? time;
  // Constructor para inicializar los atributos de la clase
  ReadChatResponse({
    required this.id,
    this.mensajeAdmin,
    this.mensajeCliente,
    this.readMessage,
    this.time,
  });
  // Método de fábrica para crear una instancia de ReadChatResponse a partir de un JSON
  factory ReadChatResponse.fromJson(Map<String, dynamic> json) {
    return ReadChatResponse(
      id: json['id_mensaje'] ?? 0,  // Valor predeterminado si es nulo
      mensajeAdmin: json['mensaje_admin'],
      mensajeCliente: json['mensaje_cliente'],
      readMessage: json['leido_mensaje'] == 1 ? true : false,  // Conversión a booleano
      time: json['fecha_envio'],
    );
  }
  // Método estático para crear una lista de instancias de ReadChatResponse a partir de una lista de JSON
  static List<ReadChatResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ReadChatResponse.fromJson(json)).toList();
  }
  // Método para actualizar el estado de lectura
  void updateReadStatus(bool readStatus) {
    readMessage = readStatus;
  }
}
