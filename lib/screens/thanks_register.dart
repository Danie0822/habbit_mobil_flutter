//Importacion de paquetes a utilizar
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

//Creación y construcción de stateful widget llamado thanks screen
class ThanksRegister extends StatelessWidget {
  const ThanksRegister({super.key});

// Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

//Incio de la construccion de la pantalla
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.12
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Widget que muestra el texto
              Text(
                "¡Muchas gracias por registrarte!",
                textAlign: TextAlign.center,
                style: AppStyles.headline5(context, colorTexto),
              ),
              SizedBox(height: height * 0.06),
              Image.asset(
                'assets/images/thanks_res.png',
                height: height * 0.3, // Ajusta la altura de la imagen
                width: width * 0.8, // Ajusta el ancho de la imagen
                fit: BoxFit.contain,
              ),
              SizedBox(
                  height: height * 0.05), // Espacio entre la imagen y el texto
              //Widget que muestra el texto
              Text(
                "Ahora, necesitamos que completes la siguiente información para poder brindarte una mejor experiencia.",
                textAlign: TextAlign.center,
                style: AppStyles.subtitle1(context),
              ),
              SizedBox(
                  height: height * 0.08), 
              Align(
                alignment: Alignment.center,
                //Widget del boton para seguir a la siguiente pantalla
                child: CustomButton(
                  onPressed: () async {
                    context.push('/ubi');
                  },
                  text: "Iniciar",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
