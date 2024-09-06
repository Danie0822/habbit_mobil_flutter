import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widget estático para desplegar la información de la empresa en el menú side.
class HeaderMenu extends StatelessWidget {
  final String name = 'Habit inmobiliaria';
  final String photo = 'assets/images/logo_amarillo.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0), // Espacio externo para el widget completo
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Esquinas redondeadas opcionales
            child: Image.asset(
              photo,
              height: 50, // Ajusta el tamaño según lo necesites
              width: 50,
              fit: BoxFit.cover, // Asegura que la imagen cubra todo el espacio
            ),
          ),
          SizedBox(width: 16.0), // Espacio entre la imagen y el texto
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
