// Declaración de modelo de la tabla Categorías
class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    print("Parsing Category: $json"); // Print al parsear cada categoría

    return Category(
      id: json['id_categoria'], // Asegúrate de que la clave coincida con la respuesta JSON
      name: json['nombre_categoria'], // Verifica que el nombre sea correcto
    );
  }

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    print("Parsing Category List: $jsonList"); // Print para la lista completa de categorías

    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
