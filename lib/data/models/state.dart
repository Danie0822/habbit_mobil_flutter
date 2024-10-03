// Declaración de modelo de la tabla States
class StatesCmb {
  // ID del estado
  final int id;
  final String name;

  StatesCmb({required this.id, required this.name});

  // Método fromJson que permite crear una instancia de State a partir de un mapa
  factory StatesCmb.fromJson(Map<String, dynamic> json) {
    return StatesCmb(
      id: json['id_estado'], // Asegúrate de que la clave coincida con la respuesta JSON
      name: json['nombre_estado'], // Verifica que el nombre sea correcto
    );
  }

  // Método fromJsonList que permite crear una lista de State a partir de una lista de mapas
  static List<StatesCmb> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => StatesCmb.fromJson(json)).toList();
  }
}
