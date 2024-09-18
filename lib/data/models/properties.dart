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
  final String? admin;
  final bool isFavorite; // Campo agregado para isFavorite

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
    this.imageUrl,
    this.admin,
    this.isFavorite = false, // Inicializamos isFavorite como false por defecto
  });

  factory PropertiesResponse.fromJson(Map<String, dynamic> json) {
    return PropertiesResponse(
      idPropiedad: json['id_propiedad'] as int?,
      title: json['Titulo'] as String?,
      status: json['Estado'] as String?,
      price: (json['Precio'] is int)
        ? (json['Precio'] as int).toDouble()
        : json['Precio'] as double?,
      zone: json['nombre_zona'] as String?,
      categories: json['nombre_categoria'] as String?,
      description: json['descripcion_propiedad'] as String?,
      direction: json['Direccion'] as String?,
      statusDisp: json['Disponibilidad'] as String?,
      type: json['tipo_propiedad'] as String?,
      bathroms: json['sanitarios_inmobiliario'] ?? 0,
      rooms: json['habitaciones_inmobiliario']  ?? 0,
      parkings: json['estacionamientos_inmobiliario']  ?? 0,
      imageUrl: json['Imagen'] as String?,
      admin: json['nombre_admin'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false, // Obtener isFavorite del JSON
    );
  }
  
  static List<PropertiesResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PropertiesResponse.fromJson(json)).toList();
  }
}
