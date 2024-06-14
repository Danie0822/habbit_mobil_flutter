import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class EditPreferences extends StatefulWidget {
  const EditPreferences({super.key});

  @override
  State<StatefulWidget> createState() => _EditPreferencesState();
}

class _EditPreferencesState extends State<EditPreferences> {
  final List<Map<String, String>> preferences = [
    {'image': 'assets/images/image1.jpg', 'text': 'Preferencia 1'},
    {'image': 'assets/images/image2.jpg', 'text': 'Preferencia 2'},
    {'image': 'assets/images/image3.jpg', 'text': 'Preferencia 3'},
  ];

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
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
              "Con cada respuesta tuya nos ayudas a mostrarte propiedades que te puedan interesar.",
              style: AppStyles.subtitle1(context),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: preferences.length,
                itemBuilder: (context, index) {
                  return PrefWidget(
                    url: preferences[index]['image']!,
                    text: preferences[index]['text']!,
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

class PrefWidget extends StatelessWidget {
  final String url;
  final String text;

  const PrefWidget({Key? key, required this.url, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(url),
            height: 240,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {},
            ),
          ),
          Text(
            text,
            style: AppStyles.headline5(context, colorTexto),
          ),
        ],
      ),
    );
  }
}
