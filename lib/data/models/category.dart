//Declaracion de modelos de la tabla Categorias
class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id_categoria'],
      name: json['nombre_categoria'],
    );
  }
}
