//Importacion de paquetes a utilizar
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart';

//Creación y construcción de stateful widget llamado thanks screen
class ThankScreen extends StatelessWidget {
  const ThankScreen({super.key});

  // Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    //Creamos una instancia de la clase del controlador
    final EstadisticasController estadisticasController = Get.find();

    // Función separada para manejar el envío de estadísticas
    Future<void> _enviarEstadisticas(BuildContext context) async {
      try {
        await estadisticasController.enviarEstadisticas();
        context.push('/login');
      } catch (error) {
      }
    }

    //Incio de la construccion de la pantalla
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Widget que muestra el texto
                Text(
                  "¡Muchas gracias por contestar!",
                  textAlign: TextAlign.center,
                  style: AppStyles.headline5(context, colorTexto),
                ),
                SizedBox(height: height * 0.02),
                //Widget que muestra el texto
                Text(
                  "Con cada respuesta tuya nos ayudas a mostrarte propiedades que te puedan interesar.",
                  textAlign: TextAlign.center,
                  style: AppStyles.subtitle1(context),
                ),
                SizedBox(
                    height:
                        height * 0.10), // Espacio entre el texto y la imagen
                Image.asset(
                  'assets/images/thanks.png',
                  height: height * 0.3, // Ajusta la altura de la imagen
                  width: width * 0.8, // Ajusta el ancho de la imagen
                  fit: BoxFit.contain,
                ),
                SizedBox(
                    height: height * 0.1), // Espacio entre la imagen y el botón
                Align(
                  alignment: Alignment.center,
                  //Widget del boton para seguir a la siguiente pantalla
                  child: CustomButton(
                    onPressed: () async {
                      _enviarEstadisticas(context);
                    },
                    text: "Finalizar",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
