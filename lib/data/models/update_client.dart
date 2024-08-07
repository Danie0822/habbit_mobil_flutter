class UpdateResponse {
  final bool success;
  final int? status;
  final List<ClientData>? clients;

  UpdateResponse({
    required this.success,
    this.status,
    this.clients,
  });

  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final clients = (data['data'] as List<dynamic>?)
        ?.map((clientJson) => ClientData.fromJson(clientJson as Map<String, dynamic>))
        .toList();

    return UpdateResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      clients: clients,
    );
  }
}

class ClientData {
  final int? clientId;
  final String? name;
  final String? email;
  final String? phone;
  final String? state;

  ClientData({
    this.clientId,
    this.name,
    this.email,
    this.phone,
    this.state,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      clientId: json['id_cliente'] as int?,
      name: json['nombre_cliente'] as String?,
      email: json['email_cliente'] as String?,
      phone: json['telefono_cliente'] as String?,
      state: json['estado_cliente'] as String?,
    );
  }
}
