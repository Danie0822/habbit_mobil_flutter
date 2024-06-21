import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

// Definición de una clase StatelessWidget llamada ChatCard
class ChatCard extends StatelessWidget {
  // Declaración de las propiedades finales de la clase
  final String title; // Título del chat
  final String name; // Nombre de la persona
  final String message; // Último mensaje enviado o recibido
  final String time; // Hora del último mensaje
  final String imageUrl; // URL de la imagen del chat

  // Constructor de la clase ChatCard con parámetros requeridos
  const ChatCard({
    required this.title,
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
  });

  // Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    // Definición del color del contenedor basado en el tema (claro u oscuro)
    final Color containerMessage = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);

    // Definición del color del texto basado en el tema
    final Color textName = ThemeUtils.getColorBasedOnBrightness(
        context, textColorNegro, lightTextColor);

    // Retorna un GestureDetector para detectar toques en el widget
    return GestureDetector(
      // Acción al tocar el widget
      onTap: () {
        context.push('/chat'); // Navega a la ruta '/chat'
      },
      // Añade un padding alrededor del contenedor
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        // Contenedor principal del chat
        child: Container(
          alignment: Alignment.center, // Alineación del contenido del contenedor
          width: double.infinity, // Ancho del contenedor
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Relleno del contenedor
          // Decoración del contenedor
          decoration: BoxDecoration(
            color: containerMessage, // Color de fondo basado en el tema
            borderRadius: const BorderRadius.all(Radius.circular(10)), // Bordes redondeados
            boxShadow: [ // Sombra del contenedor
              BoxShadow(
                color: textName.withOpacity(0.2), // Color de la sombra con opacidad
                spreadRadius: 1, // Expansión de la sombra
                blurRadius: 5, // Desenfoque de la sombra
                offset: const Offset(0, 3), // Desplazamiento de la sombra
              ),
            ],
          ),
          // Fila que contiene la imagen y los textos
          child: Row(
            children: [
              // Imagen del chat con bordes redondeados
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl, // URL de la imagen
                  width: 75, // Ancho de la imagen
                  height: 75, // Alto de la imagen
                  fit: BoxFit.cover, // Cubrir el área de la imagen
                ),
              ),
              const SizedBox(width: 10), // Espacio entre la imagen y el texto
              // Columna que contiene los textos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alineación del texto a la izquierda
                  children: [
                    // Fila que contiene el título y la hora del mensaje
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuir espacio entre los textos
                      children: [
                        // Título del chat
                        Text(
                          title,
                          style: TextStyle(
                            color: textName, // Color del texto basado en el tema
                            fontSize: 18, // Tamaño de fuente del título
                            fontWeight: FontWeight.bold,  // Hacer el título en negrita
                          ),
                        ),
                        // Hora del mensaje
                        Text(
                          time,
                          style: TextStyle(color: textName), // Color del texto basado en el tema
                        ),
                      ],
                    ),
                    const SizedBox(height: 5), // Espacio entre el título y el nombre
                    // Nombre de la persona
                    Text(
                      name,
                      style: TextStyle(
                        color: textName, // Color del texto basado en el tema
                        fontSize: 14, // Tamaño de fuente del nombre
                        fontWeight: FontWeight.bold, // Hacer el nombre en negrita
                      ),
                    ),
                    // Último mensaje enviado o recibido, truncado si es muy largo
                    Text(
                      message.length > 30 ? '${message.substring(0, 30)}...' : message,
                      style: TextStyle(color: textName), // Color del texto basado en el tema
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
