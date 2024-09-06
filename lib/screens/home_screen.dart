// ignore_for_file: deprecated_member_use, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/section_card_images.dart';
import 'package:habbit_mobil_flutter/common/widgets/habit_card.dart';
import 'package:habbit_mobil_flutter/common/widgets/informative_card.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

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
      "title": "Habit inmobiliaria", 
      "description": "Confia en nosotros para visualizar un futuro con nosotros", 
      "imagePath": "assets/images/LogoBlanco.png",
      "buttonText": "Conocer más",
      "navegation": "/onboard",
    },
    {
      "title": "Tus mensajes", 
      "description": "Ver tus chats y conversa para ponerse de acuerdo", 
      "imagePath": "assets/images/mensajeriaIcono.png",
      "buttonText": "Chatea ya", 
      "navegation": "/login",
    },
    {
      "title": "Tus me gustas", 
      "description": "Ve tus me gustas y mantente al tanto de tus propiedades deseadas", 
      "imagePath": "assets/images/corazonIcono.png",
      "buttonText": "Ver ya", 
      "navegation": "/forgot",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? primaryColorAzul
        : colorTextField;

    final Color colorTextoSub = Theme.of(context).brightness == Brightness.light
        ? normalText
        : colorTextField;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Sección de bienvenida
                Text(
                  'Buenos días',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorTexto,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$userName, ¡bienvenido!',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: colorTextoSub,
                      ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 200,
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
                        imagePath: habitItems[index]['imagePath']!,
                        currentIndex: _currentIndex,
                        itemCount: habitItems.length,
                        buttonText: habitItems[index]['buttonText']!, 
                        startColor: const Color(0xff000094),
                        endColor: const Color(0xff06065E),
                        navegation: habitItems[index]['navegation']!,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                // Sección de Informativo con mismo padding/margin
                Text(
                  'Información',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorTexto,
                      ),
                ),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    clipBehavior: Clip.none,
                    children:  const [
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
                        color: colorTexto,
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
                      navegation : '/login',
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
                      imagePath: 'encuentra.png',
                      navegation : '/recommend_option',
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
                      imagePath: 'planet.png',
                      navegation : '/map_screen',
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
