import 'package:flutter/material.dart';

class PhotoDetailScreen extends StatelessWidget {
  // Constructor de la clase
  final String imageUrl;

  const PhotoDetailScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Al tocar, regresar
        },
        child: Center(
          child: Hero(
            tag: imageUrl, // Hero tag compartido
            child: Image.network(imageUrl,
                fit: BoxFit.contain), // Imagen a pantalla completa
          ),
        ),
      ),
    );
  }
}
