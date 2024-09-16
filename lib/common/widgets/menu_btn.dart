import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// Clase para el botón del menú de la pantalla principal de abrir y cerrar
class MenuBtnScreen extends StatelessWidget {
  const MenuBtnScreen({Key? key, required this.press, required this.riveOnInit})
      : super(key: key);
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  // Diseño del botón de menú
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press, // evento de abrir y cerrar el menú
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animación de Rive (invisible)
              Opacity(
                opacity: 0.0, // Oculta la animación pero permite que onInit funcione
                child: RiveAnimation.asset(
                  'assets/rive/menu_button.riv',
                  onInit: riveOnInit,
                ),
              ),
              // Icono de menú
              const Icon(
                Icons.menu, // Icono de menú
                size: 30, // Tamaño del icono
              ),
            ],
          ),
        ),
      ),
    );
  }
}
