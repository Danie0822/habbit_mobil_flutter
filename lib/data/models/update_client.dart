class UpdateResponse {
  // Succes
  final bool success;
  // Status
  final int? status;
  // Clients
  final List<ClientData>? clients;
  // Constructor
  UpdateResponse({
    required this.success,
    this.status,
    this.clients,
  });
  // convierte en json en un array normal
  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    // extrae el objeto data
    final data = json['data'] as Map<String, dynamic>? ?? {};
    // extrae el objeto interno
    final clients = (data['data'] as List<dynamic>?)
        ?.map((clientJson) => ClientData.fromJson(clientJson as Map<String, dynamic>))
        .toList();
    // retorna el objeto
    return UpdateResponse(
      success: json['success'] ?? false,
      status: data['status'] as int?,
      clients: clients,
    );
  }
}
// Clientes data
class ClientData {
  // Client ID
  final int? clientId;
  // nombre
  final String? name;
  // correo electronico
  final String? email;
  // telefono
  final String? phone;
  // estado
  final String? state;
  // Constructor
  ClientData({
    this.clientId,
    this.name,
    this.email,
    this.phone,
    this.state,
  });
  // convierte en json en un array normal
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
