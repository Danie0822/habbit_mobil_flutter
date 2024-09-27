//Declaracion de modelos de las zonas
class Zone {
  // Atributos de la clase
  final int id;
  final String name;
  // Constructor de la clase
  Zone({required this.id, required this.name});
  // Método de fábrica para convertir un mapa en un objeto de tipo Zone
  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id_zona'],
      name: json['nombre_zona'],
    );
  }
  // Método estático para crear una lista de instancias de Zone a partir de una lista de JSON
  static List<Zone> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Zone.fromJson(json)).toList();
  }
}