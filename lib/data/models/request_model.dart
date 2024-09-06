class RequestModel {
  final int idSolicitud;
  final String tituloSolicitud;
  final String descripcionSolicitud;
  final String direccionPropiedad;
  final double precioCasa;
  final double gananciaEmpresa;
  final String exclusividadComercializacion;
  final String estadoSolicitud;
  final String fechaSolicitud;
  final String nombreCliente;
  final String telefonoCliente;
  final String emailCliente;
  final int idCliente;
  final String nombreZona;
  final String nombreCategoria;
  final int? idAdministrador;
  final String nombreAdministrador;

  RequestModel({
    required this.idSolicitud,
    required this.tituloSolicitud,
    required this.descripcionSolicitud,
    required this.direccionPropiedad,
    required this.precioCasa,
    required this.gananciaEmpresa,
    required this.exclusividadComercializacion,
    required this.estadoSolicitud,
    required this.fechaSolicitud,
    required this.nombreCliente,
    required this.telefonoCliente,
    required this.emailCliente,
    required this.idCliente,
    required this.nombreZona,
    required this.nombreCategoria,
    this.idAdministrador,
    required this.nombreAdministrador,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      idSolicitud: json['id_solicitud'],
      tituloSolicitud: json['titulo_solicitud'],
      descripcionSolicitud: json['descripcion_solicitud'],
      direccionPropiedad: json['direccion_propiedad'],
      precioCasa: json['precio_casa'].toDouble(),
      gananciaEmpresa: json['ganancia_empresa'].toDouble(),
      exclusividadComercializacion: json['exclusividad_comercializacion'],
      estadoSolicitud: json['estado_solicitud'],
      fechaSolicitud: json['fecha_solicitud'],
      nombreCliente: json['nombre_cliente'],
      telefonoCliente: json['telefono_cliente'],
      emailCliente: json['email_cliente'],
      idCliente: json['id_cliente'],
      nombreZona: json['nombre_zona'],
      nombreCategoria: json['nombre_categoria'],
      idAdministrador: json['id_administrador'],
      nombreAdministrador: json['nombre_administrador'],
    );
  }

  static List<RequestModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => RequestModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
