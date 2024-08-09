class PropertiesResponse {
  final int? idPropiedad;
  final String? title;
  final String? status;
  final double? price;
  final String? zone;
  final String? categories;
  final String? description;
  final String? direction;
  final String? statusDisp;
  final String? type;
  final int? bathroms;
  final int? rooms;
  final int? parkings;
  final String? imageUrl;

  PropertiesResponse({
    required this.idPropiedad,
    this.title,
    this.status,
    this.price,
    this.zone,
    this.categories,
    this.description,
    this.direction,
    this.statusDisp,
    this.type,
    this.bathroms,
    this.rooms,
    this.parkings,
    this.imageUrl
  });

  factory PropertiesResponse.fromJson(Map<String, dynamic> json){
    return PropertiesResponse(
      idPropiedad: json['id_propiedad'] as int?,
      title: json['titulo_propiedad'] as String?,
      status: json['estado_propiedad'] as String?,
      price: (json['precio_propiedad'] is int)
        ? (json['precio_propiedad'] as int).toDouble()
        : json['precio_propiedad'] as double?,
      zone: json['nombre_zona'] as String?,
      categories: json['nombre_categoria'] as String?,
      description: json['descripcion_propiedad'] as String?,
      direction: json['direccion_propiedad'] as String?,
      statusDisp: json['estado_disponibilidad'] as String?,
      type: json['tipo_propiedad'] as String?,
      bathroms: json['sanitarios_inmobiliario'] ?? 0,
      rooms: json['habitaciones_inmobiliario']  ?? 0,
      parkings: json['estacionamientos_inmobiliario']  ?? 0,
      imageUrl: json['imagen_principal'] as String?

    );
  }
  
  static List<PropertiesResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PropertiesResponse.fromJson(json)).toList();
  }
}