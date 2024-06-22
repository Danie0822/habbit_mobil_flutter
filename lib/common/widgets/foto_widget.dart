import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Construye una lista de widgets de fotos.
List<Widget> buildPhotos(BuildContext context, List<String> urls) {
  return urls.map((url) => buildPhoto(context, url)).toList();
}

// Construye un widget de foto individual.
Widget buildPhoto(BuildContext context, String url) {
  return GestureDetector(
    onTap: () {
      // Navega a la pantalla de detalles de la foto al hacer clic.
      context.push("/PhotoDetailScreen", extra: url);
    },
    child: Hero(
      tag: url, // Etiqueta para la animación Hero.
      child: AspectRatio(
        aspectRatio: 3 / 2, 
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(url),
              fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor.
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8), // Fondo translúcido.
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Ver', // Texto en la esquina inferior izquierda.
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
