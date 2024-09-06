class ImageModel {
  final int id;
  final String url;
  final String? imageUrl;

  ImageModel({required this.id, required this.url, this.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id_imagen'],
      url: json['imagen_url'],
      imageUrl: json['imagen'] as String?
    );
  }

  static List<ImageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ImageModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}