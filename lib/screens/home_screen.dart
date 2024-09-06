// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/section_card_images.dart';
import 'package:habbit_mobil_flutter/common/widgets/informative_card.dart';

class HomeScreenOne extends StatefulWidget {
  const HomeScreenOne({super.key});

  @override
  State<HomeScreenOne> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenOne> {
  final String userName = "Daniel"; // Nombre del usuario
  int _currentIndex = 0; // Índice actual para el slider

  final List<Map<String, String>> habitItems = [
    {
      "title": "Habit inmobiliaria 1",
      "description":
          "Consulta de asesoría para visualizar tu futuro con nosotros",
    },
    {
      "title": "Habit inmobiliaria 2",
      "description": "Descubre nuevas oportunidades en el mercado inmobiliario",
    },
    {
      "title": "Habit inmobiliaria 3",
      "description":
          "Confía en nuestros expertos para guiarte en el camino inmobiliario",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
                16.0), // Padding global para todo el contenido
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Sección de bienvenida
                Text(
                  'Buenos días',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$userName, ¡bienvenido!',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.black45,
                      ),
                ),
                const SizedBox(height: 20),
                // Slider de Habit inmobiliaria
                Container(
                  height: 180, // Altura del contenedor del slider
                  child: PageView.builder(
                    itemCount: habitItems.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return HabitCard(
                        title: habitItems[index]['title']!,
                        description: habitItems[index]['description']!,
                      );
                    },
                  ),
                ),
                // Puntos del slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    habitItems.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: _currentIndex == index ? 12.0 : 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Colors.blue
                            : Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Sección de Informativo con mismo padding/margin
                Text(
                  'Informativo',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                  ),
                SizedBox(
                  height:
                      120, // Ajusta la altura para dar más espacio a las sombras
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12), // Padding superior e inferior añadido
                    clipBehavior:
                        Clip.none, // Evita que el ListView recorte las sombras
                    children: const [
                      InformativeCard(
                        icon: Icons.notifications,
                        label: 'Mensajes sin leer',
                        count: '12',
                        showNotification: true,
                      ),
                      SizedBox(width: 16),
                      InformativeCard(
                        icon: Icons.favorite,
                        label: 'Tus me gustas',
                        count: '43',
                      ),
                      SizedBox(width: 16),
                      InformativeCard(
                        icon: Icons.chat_bubble_rounded,
                        label: 'Tus chats',
                        count: '5',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                // Sección Explorar con mismo padding/margin
                Text(
                  'Explorar',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionCardWithImage(
                      title: 'Lee',
                      description:
                          'Encuentra artículos interesantes y noticias de tu interés.',
                      backgroundGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffFFBF3E), Color(0xffA17721)],
                      ),
                      buttonText: 'Aprovecha y lee',
                      imagePath: 'blog.png',
                    ),
                    SizedBox(height: 16),
                    SectionCardWithImage(
                      title: 'Encuentra',
                      description:
                          'Descubre apartamentos de tu interés a través de nuestra app.',
                      backgroundGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffD3140E), Color(0xff430622)],
                      ),
                      buttonText: '¡Encuentra ya!',
                      imagePath: 'encuentra.png', // Ruta de la imagen
                    ),
                    SizedBox(height: 16),
                    SectionCardWithImage(
                      title: 'Descubre',
                      description:
                          'Explora el mundo con nuestras recomendaciones de viajes.',
                      backgroundGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff4FCA37), Color(0xff27641B)],
                      ),
                      buttonText: '¡Descubre!',
                      imagePath: 'planet.png', // Ruta de la imagen
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget para las tarjetas con el slider
class HabitCard extends StatelessWidget {
  final String title;
  final String description;

  const HabitCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xff0d47a1), // Fondo azul similar a la imagen
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xff0d47a1),
                ),
                child: const Text('Conocer más'),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz, color: Colors.white)
            ],
          ),
        ],
      ),
    );
  }
}
