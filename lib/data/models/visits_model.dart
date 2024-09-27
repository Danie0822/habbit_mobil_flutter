class VisitModel {
  // Atributos de la clase
  final int IdVisita;
  final String tituloVisita;
  final DateTime fechaHoraInicio;
  final DateTime fechaHoraFinalizacion;
  final int idCliente;
  final int idPropiedad;
  final String estadoVisita;
  final int idAdmin;
  final String nombreAdmin;
  // Constructor de la clase
  VisitModel({
    required this.IdVisita,
    required this.tituloVisita,
    required this.fechaHoraInicio,
    required this.fechaHoraFinalizacion,
    required this.idCliente,
    required this.idPropiedad,
    required this.estadoVisita,
    required this.idAdmin,
    required this.nombreAdmin
  });
  // Método de fábrica para convertir un mapa en un objeto de tipo VisitModel
  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      IdVisita: json['id_visita'],
      tituloVisita: json['titulo_visita'],
      fechaHoraInicio: DateTime.parse(json['fecha_hora_inicio']), // Convierte de String a DateTime
      fechaHoraFinalizacion: DateTime.parse(json['fecha_hora_finalizacion']), // Convierte de String a DateTime
      idCliente: json['id_cliente'],
      idPropiedad: json['id_propiedad'],
      estadoVisita: json['estado_visita'],
      idAdmin: json['id_administrador'], 
      nombreAdmin: json['nombre_administrador'],
    );
  }
  // Método estático para crear una lista de instancias de VisitModel a partir de una lista de JSON
  static List<VisitModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => VisitModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
