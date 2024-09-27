class ImageModel {
  // ImageModel class
  // Id de la imagen
  final int id;
  // URL de la imagen
  final String url;
  // Imagen
  final String? imageUrl;

  ImageModel({required this.id, required this.url, this.imageUrl});
  // Método fromJson que permite crear una instancia de ImageModel a partir de un mapa
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id_imagen'],
      url: json['imagen_url'],
      imageUrl: json['imagen'] as String?
    );
  }
  // Método fromJsonList que permite crear una lista de ImageModel a partir de una lista de mapas
  static List<ImageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ImageModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}