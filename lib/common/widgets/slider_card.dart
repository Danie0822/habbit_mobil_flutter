import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SliderCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final int currentIndex;
  final int itemCount;
  final String buttonText;
  final Color startColor;
  final Color endColor;
  final String navegation;

  const SliderCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.currentIndex,
    required this.itemCount,
    required this.buttonText,
    required this.startColor,
    required this.endColor,
    required this.navegation,
  });

  @override
  Widget build(BuildContext context) {
    // Obteniendo el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Ajustes dinámicos de tamaños y espaciamientos con límites
    double cardPadding = screenWidth * 0.04; // Padding dinámico según el ancho
    double cardHeight =
        screenWidth < 600 ? screenHeight * 0.35 : screenHeight * 0.4;
    double imageSize =
        screenWidth * 0.2; // Imagen será el 20% del ancho de la pantalla
    double titleFontSize = screenWidth * 0.06; // Tamaño del título
    double descriptionFontSize =
        screenWidth * 0.025; // Tamaño más pequeño de la descripción
    double buttonFontSize =
        screenWidth * 0.035; // Tamaño más pequeño del texto del botón

    return Container(
      padding: EdgeInsets.all(cardPadding), // Padding dinámico
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: cardHeight, // Tamaño ajustable de la tarjeta
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            startColor,
            endColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Texto a la izquierda
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  titleFontSize, // Ajuste dinámico del texto
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 3, // Limitar a 3 líneas para evitar overflow
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontSize:
                                  descriptionFontSize, // Ajuste más pequeño del texto de la descripción
                            ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.push(navegation);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth *
                                0.04, // Reducir padding horizontal
                            vertical:
                                screenHeight * 0.01, // Reducir padding vertical
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xff0d47a1),
                          minimumSize: Size(0,
                              0), // Asegurar que el botón se ajuste a su contenido
                          tapTargetSize: MaterialTapTargetSize
                              .shrinkWrap, // Eliminar espacio extra alrededor del botón
                        ),
                        child: FittedBox(
                          // Ajustar el contenido dentro del botón
                          child: Text(
                            buttonText,
                            style: TextStyle(fontSize: buttonFontSize),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Imagen ajustable según el tamaño de la pantalla
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    height: imageSize,
                    width: imageSize,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Indicadores del slider dentro de la card
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              itemCount,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: currentIndex == index ? 12.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
