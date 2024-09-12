import 'package:flutter/material.dart';

// Definición de una clase StatelessWidget llamada MyTextField
class MyTextField extends StatelessWidget {
  // Declaración de las propiedades finales de la clase
  final String hint; // Texto de sugerencia que se muestra dentro del campo de texto
  final bool isPassword; // Indica si el campo de texto es para una contraseña
  final IconData icon; // Icono que se muestra al inicio del campo de texto
  final TextEditingController? controller; // Controlador opcional para el campo de texto
  final VoidCallback? onClearPressed; // Callback opcional cuando se presiona para limpiar el texto
  final ValueChanged<String>? onChanged; // Callback opcional cuando el texto cambia
  final Widget? suffixIcon; // Widget opcional que se muestra al final del campo de texto

  // Constructor de la clase MyTextField con parámetros requeridos y opcionales
  const MyTextField({
    Key? key,
    required this.hint,
    required this.isPassword,
    required this.icon,
    this.controller,
    this.onClearPressed,
    this.onChanged,
    this.suffixIcon,
  }) : super(key: key);

  // Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    // Definición del color de fondo basado en el tema (claro u oscuro)
    Color fillColor = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[200]!
        : Colors.grey[700]!;
    // Definición del color del icono basado en el tema (claro u oscuro)
    Color iconColor = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[600]!
        : Colors.grey[300]!;

    // Retorna un contenedor que envuelve el campo de texto
    return Container(
      // Margen vertical
      margin: const EdgeInsets.symmetric(vertical: 10),
      // Decoración del contenedor
      decoration: BoxDecoration(
        color: fillColor, // Color de fondo del contenedor
        borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
        boxShadow: [ // Sombra del contenedor
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Color de la sombra con opacidad
            spreadRadius: 2, // Expansión de la sombra
            blurRadius: 5, // Desenfoque de la sombra
            offset: const Offset(0, 3), // Desplazamiento de la sombra
          ),
        ],
      ),
      // Campo de texto dentro del contenedor
      child: TextFormField(
        controller: controller, // Controlador del campo de texto
        obscureText: isPassword, // Si el texto es oculto (para contraseñas)
        onChanged: onChanged, // Callback cuando el texto cambia
        maxLines: 5, // Máximo de 5 líneas
        minLines: 1, // Mínimo de 1 línea
        // Decoración del campo de texto
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Relleno del contenido
          border: OutlineInputBorder( // Borde del campo de texto
            borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
            borderSide: BorderSide.none, // Sin borde
          ),
          hintText: hint, // Texto de sugerencia
          hintStyle: TextStyle( // Estilo del texto de sugerencia
            color: Colors.grey[500]!, // Color del texto de sugerencia
            fontSize: 16, // Tamaño de fuente del texto de sugerencia
          ),
          prefixIcon: Container( // Icono al inicio del campo de texto
            padding: const EdgeInsets.all(12), // Relleno alrededor del icono
            child: Icon(icon, color: iconColor), // Icono con el color definido
          ),
          suffixIcon: suffixIcon, // Widget opcional al final del campo de texto
          filled: true, // Indica que el campo está lleno con un color de fondo
          fillColor: fillColor, // Color de fondo del campo de texto
        ),
        style: TextStyle( // Estilo del texto del campo de texto
          color: Theme.of(context).textTheme.bodyLarge?.color, // Color del texto basado en el tema
        ),
      ),
    );
  }
}
