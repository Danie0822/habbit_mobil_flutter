import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_pref.dart'; // Importa el archivo con las tarjetas y la lista

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
      'destinationRoute': '/zone'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Text(
              "Edita tus preferencias",
              style: AppStyles.headline5(context, colorTexto),
            ),
            const SizedBox(height: 10),
            Text(
              "Elige la opción que deseas editar",
              style: AppStyles.subtitle1(context),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: preferences.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos elementos por fila
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio:
                      1.0, // Relación de aspecto 1:1 para círculos
                ),
                itemBuilder: (context, index) {
                  return PrefWidget(
                    text: preferences[index]['text']!,
                    lottieUrl: preferences[index]['lottieUrl']!,
                    destinationRoute: preferences[index]['destinationRoute']!,
                    index: index, // Pasa el índice a PrefWidget
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
