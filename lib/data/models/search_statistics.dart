class EstadisticasBusquedas {
  String? idCliente;
  String ubicacionPreferida;
  double latitudPreferida;
  double longitudPreferida;
  double precioMin;
  double precioMax;
  int idCategoria;
  int idZona;

  EstadisticasBusquedas({
    this.idCliente,
    required this.ubicacionPreferida,
    required this.latitudPreferida,
    required this.longitudPreferida,
    required this.precioMin,
    required this.precioMax,
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
    'id_categoria': idCategoria,
    'id_zona': idZona,
  };
}
