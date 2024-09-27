class MapResponse {
  // Atributos de la clase MapResponse
  final bool success;
  final int? status;
  final int? idProperty;
  final String? title;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;
  final String? description;
  final String? address;
  final String? type;
  final double? price;
  final String? statutsProperty;

  MapResponse({
    required this.success,
    this.status,
    this.idProperty,
    this.title,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.description,
    this.address,
    this.type,
    this.price,
    this.statutsProperty,
  });

  // Método de fábrica para crear una instancia de MapResponse a partir de un JSON
  factory MapResponse.fromJson(Map<String, dynamic> json) {
    return MapResponse(
      success: json['success'] ?? false,
      status: json['status'] as int?,
      idProperty: json['id_propiedad'] as int?,
      title: json['titulo_propiedad'] as String?,
      latitude: json['latitud_propiedad'] != null
          ? (json['latitud_propiedad'] is int)
              ? (json['latitud_propiedad'] as int).toDouble()
              : json['latitud_propiedad'] as double?
          : null,
      longitude: json['longitud_propiedad'] != null
          ? (json['longitud_propiedad'] is int)
              ? (json['longitud_propiedad'] as int).toDouble()
              : json['longitud_propiedad'] as double?
          : null,
      imageUrl: json['primera_imagen'] as String?,
      description: json['descripcion_propiedad'] as String?,
      address: json['direccion_propiedad'] as String?,
      type: json['tipo_propiedad'] as String?,
      price: json['precio_propiedad'] != null
          ? (json['precio_propiedad'] is int)
              ? (json['precio_propiedad'] as int).toDouble()
              : json['precio_propiedad'] as double?
          : null,
      statutsProperty: json['estado_propiedad'] as String?,
    );
  }
  // Método estático para crear una lista de instancias de MapResponse a partir de una lista de JSON
  static List<MapResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MapResponse.fromJson(json)).toList();
  }
}
