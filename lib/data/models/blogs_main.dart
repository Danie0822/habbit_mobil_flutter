class BlogsResponse {
  /// Atributos de la clase BlogsResponse
  final int? idBlogs;
  final String? title;
  final String? description;
  final double? rating;
  final String? imageUrl;

  BlogsResponse({
    required this.idBlogs,
    this.title,
    this.description,
    this.rating,
    this.imageUrl,
  });

  /// Método fromJson que permite crear una instancia de BlogsResponse a partir de un mapa
  factory BlogsResponse.fromJson(Map<String, dynamic> json){
    return BlogsResponse(
      idBlogs: json['id_blog'] as int?,
      title: json['titulo_blog'] as String?,
      description: json['descripcion_blog'] as String?,
      rating: (json['calificacion_promedio'] is int)
        ? (json['calificacion_promedio'] as int).toDouble()
        : json['calificacion_promedio'] as double?,
      imageUrl: json['imagen_blog'] as String?,

    );
  }
  
  /// Método fromJsonList que permite crear una lista de BlogsResponse a partir de una lista de mapas
  static List<BlogsResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BlogsResponse.fromJson(json)).toList();
  }
}