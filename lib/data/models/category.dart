// Declaración de modelo de la tabla Categorías
class Category {
  // ID de la categoría
  final int id;
  final String name;

  Category({required this.id, required this.name});

  // Método fromJson que permite crear una instancia de Category a partir de un mapa
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json[
          'id_categoria'], // Asegúrate de que la clave coincida con la respuesta JSON
      name: json['nombre_categoria'], // Verifica que el nombre sea correcto
    );
  }

  // Método fromJsonList que permite crear una lista de Category a partir de una lista de mapas
  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
