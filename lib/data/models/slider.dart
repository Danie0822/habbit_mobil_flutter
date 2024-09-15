class SliderResponse {
  final bool success;
  final int? status;
  final int? idProperty;
  final String? propertyTitle;
  final double? distanceKm;
  final String? imageUrl;
  final String? propertyState;
  final String? propertyType;


  // Constructor para inicializar los atributos de la clase
  SliderResponse({
    required this.success,
    this.status,
    this.idProperty,
    this.propertyTitle,
    this.distanceKm,
    this.imageUrl,
    this.propertyState,
    this.propertyType,
  });

  // Método de fábrica para crear una instancia de MessageResponse a partir de un JSON
  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    return SliderResponse(
      success: json['success'] ?? false,
      status: json['status'] as int?,
      idProperty: json['id_propiedad'] as int?,
      propertyTitle: json['titulo_propiedad'] as String?,
      distanceKm: json['distancia_km'] as double?,
      imageUrl: json['imagen_url'] as String?,
      propertyState: json['estado_propiedad'] as String?,
      propertyType: json['tipo_propiedad'] as String?,
    );
  }

  // Método estático para crear una lista de instancias de MessageResponse a partir de una lista de JSON
  static List<SliderResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SliderResponse.fromJson(json as Map<String, dynamic>)).toList();
  }
}
