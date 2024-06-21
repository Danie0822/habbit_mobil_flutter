import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart'; 
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

// Definición de una clase StatelessWidget llamada MessageWidget
class MessageWidget extends StatelessWidget {
  // Declaración de las propiedades finales de la clase
  final String message; // Mensaje de texto que se muestra
  final bool isSentByMe; // Indica si el mensaje fue enviado por el usuario actual

  // Constructor de la clase MessageWidget con parámetros requeridos
  const MessageWidget({
    Key? key,
    required this.message,
    required this.isSentByMe,
  }) : super(key: key);

  // Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {

    // Definición del color de fondo del mensaje basado en el tema (claro u oscuro)
    final Color mandado = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageLight, contenedorMensajeDark);

    // Definición del color de fondo del mensaje del receptor basado en el tema
    final Color contestador = ThemeUtils.getColorBasedOnBrightness(
    context, colorBackGroundMessageWidget, backgroundColor);
    
    // Definición del color del texto basado en el tema
    final Color textoColor = ThemeUtils.getColorBasedOnBrightness(
        context, textColorNegro, lightTextColor);

    // Asignación de color de fondo basado en si el mensaje fue enviado por el usuario
    Color bgColor = isSentByMe ? mandado : contestador;
    // Asignación de color de texto basado en si el mensaje fue enviado por el usuario
    Color textColor = isSentByMe ? textoColor : lightTextColor;

    // Retorna un Align widget que alinea el contenedor del mensaje
    return Align(
      // Alineación del mensaje a la derecha si es enviado por el usuario, a la izquierda si no
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      // Contenedor que envuelve el mensaje
      child: Container(
        // Margen inferior
        margin: const EdgeInsets.only(bottom: 20.0),
        // Relleno alrededor del contenido
        padding: const EdgeInsets.all(12.0),
        // Limitar el ancho del contenedor al 80% del ancho de la pantalla
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        // Decoración del contenedor
        decoration: BoxDecoration(
          color: bgColor, // Color de fondo basado en si el mensaje fue enviado por el usuario
          borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
          boxShadow: [ // Sombra del contenedor
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Color de la sombra con opacidad
              spreadRadius: 1, // Expansión de la sombra
              blurRadius: 4, // Desenfoque de la sombra
              offset: const Offset(0, 2), // Desplazamiento de la sombra
            ),
          ],
        ),
        // Texto del mensaje
        child: Text(
          message, // Mensaje de texto que se muestra
          style: TextStyle(
            color: textColor, // Color del texto basado en si el mensaje fue enviado por el usuario
            fontSize: 16.0, // Tamaño de fuente del texto
          ),
        ),
      ),
    );
  }
}
