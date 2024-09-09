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

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            startColor, // Usado aquí
            endColor, // Usado aquí
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Texto a la izquierda
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.push('${navegation}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xff0d47a1),
                      ),
                      child: Text(buttonText), // Usado aquí
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Imagen más pequeña a la derecha
              ClipRRect(
                child: Image.asset(
                  imagePath,
                  height: 80,
                  width: 80,
                ),
              ),
            ],
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
