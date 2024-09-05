import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class HomeScreenOne extends StatefulWidget {
  const HomeScreenOne({super.key});

  @override
  State<HomeScreenOne> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenOne> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: SingleChildScrollView(
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
                      color: Theme.of(context).brightness == Brightness.dark
                          ? lightTextColor
                          : textColorNegro,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Explora lo que puedes hacer hoy',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? lightTextColor
                          : textColor,
                    ),
              ),
              const SizedBox(height: 20),
              // Tarjeta principal de Habit Inmobiliaria
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Habit inmobiliaria',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Consulta de asesoría para visualizar tu futuro con nosotros',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: whiteColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        foregroundColor: primaryColor,
                      ),
                      child: const Text('Conocer más'),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Sección Informativo con iconos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  IconWithLabel(icon: Icons.access_time, label: 'Tiempo sin leer'),
                  IconWithLabel(icon: Icons.favorite, label: 'Me gusta'),
                  IconWithLabel(icon: Icons.comment, label: 'Comentarios'),
                ],
              ),
              const SizedBox(height: 20),
              // Sección Explorar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionCard(
                    title: 'Lee',
                    description:
                        'Encuentra artículos interesantes y noticias de tu interés.',
                    backgroundColor: Colors.amber,
                    buttonText: 'Aprovecha y lee',
                    buttonColor: Colors.orangeAccent,
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Encuentra',
                    description:
                        'Descubre apartamentos de tu interés a través de nuestra app.',
                    backgroundColor: Colors.red,
                    buttonText: '¡Encuentra ya!',
                    buttonColor: Colors.redAccent,
                  ),
                  const SizedBox(height: 16),
                  SectionCard(
                    title: 'Descubre',
                    description:
                        'Explora el mundo con nuestras recomendaciones de viajes.',
                    backgroundColor: Colors.green,
                    buttonText: '¡Descubre!',
                    buttonColor: Colors.greenAccent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget reutilizable para las tarjetas de las secciones
class SectionCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final String buttonText;
  final Color buttonColor;

  const SectionCard({
    super.key,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: whiteColor,
                ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: whiteColor,
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}

// Widget para mostrar los iconos con etiquetas
class IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconWithLabel({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).iconTheme.color, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
