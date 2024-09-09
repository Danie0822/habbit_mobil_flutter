class HomeScreenResponse{
  final bool success;
  final int? status;
  final int? idCliente;
  final String? nombre;
  final int? messagesNotRead;
  final int? likes;
  final int? chats;

  HomeScreenResponse({
    required this.success,
    this.status,
    this.idCliente,
    this.nombre,
    this.messagesNotRead,
    this.likes,
    this.chats,
  });

   // Método de fábrica para crear una instancia de MessageResponse a partir de un JSON
  factory HomeScreenResponse.fromJson(Map<String, dynamic> json) {
    return HomeScreenResponse(
      success: json['success'] ?? false,
      status: json['status'] as int?,
      idCliente: json['id_cliente'] as int?,
      nombre: json['nombre_cliente'] as String?,
      messagesNotRead: json['mensajes_no_leidos'] as int?,
      likes: json['me_gustas'] as int?,
      chats: json['total_chats'] as int?,
    );
  }

  // Método estático para crear una lista de instancias de MessageResponse a partir de una lista de JSON
  static List<HomeScreenResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HomeScreenResponse.fromJson(json as Map<String, dynamic>)).toList();
  }
}