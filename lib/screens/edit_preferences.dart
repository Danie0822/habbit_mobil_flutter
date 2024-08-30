import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:lottie/lottie.dart'; // Importa el archivo con las tarjetas y la lista

// Creación y construcción de stateful widget llamado EditPreferences
class EditPreferences extends StatefulWidget {
  const EditPreferences({super.key});

  @override
  State<StatefulWidget> createState() => _EditPreferencesState();
}

class _EditPreferencesState extends State<EditPreferences> {
  // Lista de tarjetas de preferencia
  final List<Map<String, String>> preferences = [
    {
      'text': 'Ubicación',
      'lottieUrl':
          'https://lottie.host/bf2fe8d3-d5a5-4302-88d3-55daea2d8531/RuRaGNd3Ut.json',
      'destinationRoute': '/ubi'
    },
    {
      'text': 'Precio',
      'lottieUrl':
          'https://lottie.host/3ac43d64-bac4-4254-a583-418a5a6c6c9a/LOQKQYlQrn.json',
      'destinationRoute': '/price'
    },
    {
      'text': 'Categorías',
      'lottieUrl':
          'https://lottie.host/ca5bf7aa-8e8a-40c6-b2b9-aad377a37773/k3mtC3AYsm.json',
      'destinationRoute': '/category'
    },
    {
      'text': 'Zonas',
      'lottieUrl':
          'https://lottie.host/9de345f9-4d4f-44b1-8a92-4a20da167e29/ABG1WgpQ4W.json',
      'destinationRoute': '/zone_update'
    },
  ];

  // Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    // Inicio de la construcción de la pantalla
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Widget que muestra el texto
            Text(
              "Edita tus preferencias",
              style: AppStyles.headline5(context, colorTexto),
            ),
            const SizedBox(height: 10),
            // Widget que muestra el texto
            Text(
              "Elige la opción que deseas editar",
              style: AppStyles.subtitle1(context),
            ),
            Expanded(
              // Widget para renderizar cada panel de preferencia en cuadrícula
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calcula el número de columnas según el ancho de la pantalla
                  int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                  return GridView.builder(
                    itemCount: preferences.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, // Ajusta el número de columnas
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0, // Relación de aspecto 1:1 para círculos
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.push(preferences[index]['destinationRoute']!);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Lottie.network(preferences[index]['lottieUrl']!),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  preferences[index]['text']!,
                                  style: AppStyles.subtitle1(context)?.copyWith(
                                    color: colorTexto,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
