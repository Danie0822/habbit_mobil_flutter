class ImageModel {
  final int id;
  final String url;

  ImageModel({required this.id, required this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id_imagen'],
      url: json['imagen_url'],
    );
  }

  static List<ImageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ImageModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}