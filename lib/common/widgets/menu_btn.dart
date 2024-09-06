import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// Clase para el boton del menu de la pantalla principal de abrir y cerrar
class MenuBtnScreen extends StatelessWidget {
  const MenuBtnScreen({Key? key, required this.press, required this.riveOnInit})
      : super(key: key);
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  @override
  // Diseño del boton de menu
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press, // evento de abrir y cerrar el menu
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Colors.white, shape: BoxShape.circle,
            // boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0,0), blurRadius: 8)],
          ),
          child: RiveAnimation.asset(
            'assets/rive/menu_button.riv',
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
