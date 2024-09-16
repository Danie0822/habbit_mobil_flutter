//Declaracion de modelos de las zonas
class Zone {
  final int id;
  final String name;

  Zone({required this.id, required this.name});

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id_zona'],
      name: json['nombre_zona'],
    );
  }
  static List<Zone> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Zone.fromJson(json)).toList();
  }
}