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

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.1),
              Text(
                "¡Muchas gracias por contestar!",
                textAlign: TextAlign.center,
                style: AppStyles.headline5(context, colorTexto),
              ),
              SizedBox(height: height * 0.02),
              Text(
                "Con cada respuesta tuya nos ayudas a mostrarte propiedades que te puedan interesar.",
                textAlign: TextAlign.center,
                style: AppStyles.subtitle1(context),
              ),
              SizedBox(height: height * 0.05), // Espacio entre el texto y la imagen
              Image.asset(
                'assets/images/thanks.png',
                height: height * 0.3, // Ajusta la altura de la imagen
                width: width * 0.6, // Ajusta el ancho de la imagen
                fit: BoxFit.contain,
              ),
              SizedBox(height: height * 0.1), // Espacio entre la imagen y el botón
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  text: "Finalizar",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
