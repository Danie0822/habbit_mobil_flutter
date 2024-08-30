class EstadisticasBusquedas {
  String? idCliente;
  String ubicacionPreferida;
  double latitudPreferida;
  double longitudPreferida;
  double precioMin;
  double precioMax;
  String fecha_modificacion;
  int idCategoria;
  int idZona;

  EstadisticasBusquedas({
    this.idCliente,
    required this.ubicacionPreferida,
    required this.latitudPreferida,
    required this.longitudPreferida,
    required this.precioMin,
    required this.precioMax,
    required this.fecha_modificacion,
    required this.idCategoria,
    required this.idZona,
  });

  Map<String, dynamic> toJson() => {
    'id_cliente': idCliente,
    'ubicacion_preferida': ubicacionPreferida,
    'latitud_preferida': latitudPreferida,
    'longitud_preferida': longitudPreferida,
    'precio_min': precioMin,
    'precio_max': precioMax,
    'fecha_modificacion': fecha_modificacion,
    'id_categoria': idCategoria,
    'id_zona': idZona,
  };

  factory EstadisticasBusquedas.fromJson(Map<String, dynamic> json) {
    return EstadisticasBusquedas(
      idCliente: json['id_cliente'] as String?,
      ubicacionPreferida: json['ubicacion_preferida'] as String,
      latitudPreferida: (json['latitud_preferida'] as num).toDouble(),
      longitudPreferida: (json['longitud_preferida'] as num).toDouble(),
      precioMin: (json['precio_min'] as num).toDouble(),
      precioMax: (json['precio_max'] as num).toDouble(),
      fecha_modificacion: json['fecha_modificacion'] as String,
      idCategoria: json['id_categoria'] as int,
      idZona: json['id_zona'] as int,
    );
  }
}
