import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class ThankScreen extends StatelessWidget {
  const ThankScreen({super.key});

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "¡Muchas gracias por contestar!",
            style: AppStyles.headline5(context, colorTexto),
          ),
          const SizedBox(height: 10),
          Text(
            "Con cada respuesta tuya nos ayudas a mostrarte propiedades que te puedan interesar.",
            style: AppStyles.subtitle1(context),
          ),
          const SizedBox(height: 20), // Espacio entre el texto y la imagen
          Image.asset('assets/images/thanks.png'), // Imagen local
          const SizedBox(height: 20), // Espacio entre la imagen y el botón
          Align(
            alignment: Alignment.center,
            child: CustomButton(
              onPressed: () {
                context.push('/ubi');
              },
              text: "Crear cuenta",
            ),
          ),
        ],
      ),
    ));
  }
}  
