class PropertiesSmallResponse {
  // Definimos los campos que vamos a recibir del JSON
  final int? idPropiedad;
  final String? title;
  final String? status;
  final double? price;
  final String? direction;
  final String? type;
  final String? imageUrl;
  final int? likes;
  // Constructor de la clase PropertiesResponse
  PropertiesSmallResponse({
    required this.idPropiedad,
    this.title,
    this.status,
    this.price,
    this.direction,
    this.type,
    this.imageUrl,
    this.likes,
  });
  // Método de fábrica para crear una instancia de PropertiesResponse a partir de un JSON
  factory PropertiesSmallResponse.fromJson(Map<String, dynamic> json) {
    return PropertiesSmallResponse(
      idPropiedad: json['id_propiedad'] as int?,
      title: json['titulo'] as String?,
      status: json['tipo'] as String?,
      price: (json['precio'] is int)
        ? (json['precio'] as int).toDouble()
        : json['precio'] as double?,
      direction: json['direccion'] as String?,
      type: json['tipo_propiedad'] as String?,
      imageUrl: json['imagen_url'] as String?,
      likes: json['likes'] as int?,
    );
  }
  // Método estático para crear una lista de instancias de PropertiesResponse a partir de una lista de JSON
  static List<PropertiesSmallResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PropertiesSmallResponse.fromJson(json)).toList();
  }
}
