class PropertiesResponse {
  // Definimos los campos que vamos a recibir del JSON
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
  final int isFavorite; // Campo agregado para isFavorite
  final int? EcoFriendly;
  final int? InteresSocial;
  // Constructor de la clase PropertiesResponse
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
    this.EcoFriendly,
    this.InteresSocial,
    this.admin,
    this.isFavorite = 0, // Inicializamos isFavorite como false por defecto
  });
  // Método de fábrica para crear una instancia de PropertiesResponse a partir de un JSON
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
      rooms: json['habitaciones_inmobiliario'] ?? 0,
      parkings: json['estacionamientos_inmobiliario'] ?? 0,
      imageUrl: json['Imagen'] as String?,
      admin: json['nombre_admin'] as String?,
      EcoFriendly: json['EcoFriendly'] as int? ?? 0,
      InteresSocial: json['InteresSocial'] as int? ?? 0,
      isFavorite:
          json['isFavorite'] as int? ?? 0, // Obtener isFavorite del JSON
    );
  }
  // Método estático para crear una lista de instancias de PropertiesResponse a partir de una lista de JSON
  static List<PropertiesResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PropertiesResponse.fromJson(json)).toList();
  }
}
