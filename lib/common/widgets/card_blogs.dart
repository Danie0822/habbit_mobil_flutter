import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/button_blog.dart';
import 'package:habbit_mobil_flutter/data/models/blogs_main.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class BlogCard extends StatelessWidget {
  final BlogsResponse dataBlogs;

  const BlogCard({
    super.key,
    required this.dataBlogs, // Requiere la función
  });

  @override
  Widget build(BuildContext context) {
    final double valoracion = dataBlogs.rating ?? 0.0; // Valor por defecto si es null
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: 340,
              margin: const EdgeInsets.only(top: 30),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(
                '${Config.imagen}${dataBlogs.imageUrl}', // Proporcionar una cadena vacía si es null
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Error al cargar la imagen',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  dataBlogs.title ?? 'Título no disponible', // Valor por defecto si es null
                  style: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(height: 10),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color.fromARGB(255, 255, 230, 8),
                          size: 24,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$valoracion', // Muestra la calificación en lugar de un valor fijo
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 28, bottom: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomButton(
                  onPressed: () {
                    context.push('/detailBlogs', extra: dataBlogs);
                  } , // Convertir ID a String
                  text: "Ver",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
