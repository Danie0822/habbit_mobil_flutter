import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el color de fondo del botón del tema actual
    final Color buttonColor = Theme.of(context).colorScheme.primary;
    // Obtener el color del texto del botón del tema actual
    final Color textColor = Theme.of(context).colorScheme.onPrimary;

    return SizedBox(
      width: MediaQuery.of(context).size.width /2.9,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Establecer el color de fondo del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40), 
          ),
          elevation: 5, 
          shadowColor: Colors.black.withOpacity(0.2), // Establecer el color de sombra
          splashFactory: NoSplash.splashFactory, // Desactivar el efecto de splash
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor, // Establecer el color del texto del botón
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
