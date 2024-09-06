// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widget estático para desplegar la información de la empresa en el menú side.
class HeaderMenu extends StatelessWidget {
  final String name = 'Habit inmobiliaria';
  final String photo = 'assets/images/logoLight.png';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        backgroundImage: AssetImage(photo),
        // Si no hay foto, se muestra un ícono por defecto.
        child: photo == null
            ? const Icon(
                CupertinoIcons.person,
                color: Colors.white,
              )
            : null,
      ),
      title: Text(name, style: const TextStyle(color: Colors.white)),
    );
  }
}