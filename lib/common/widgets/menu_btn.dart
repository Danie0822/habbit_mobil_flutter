import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuBtnScreen extends StatefulWidget {
  const MenuBtnScreen({Key? key, required this.riveOnInit, required this.press})
      : super(key: key);

  final ValueChanged<Artboard> riveOnInit;
  final VoidCallback press;

  @override
  _MenuBtnScreenState createState() => _MenuBtnScreenState();
}

class _MenuBtnScreenState extends State<MenuBtnScreen> {
  bool isMenuOpen = false; // Estado para controlar si el menú está abierto o cerrado

  // Método para manejar el estado del botón y ejecutar la función `press`
  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen; // Cambia entre el ícono de menú y la "X"
    });
    widget.press(); // Ejecuta la función de abrir/cerrar el menú
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: toggleMenu, // Cambia entre el ícono de menú y la "X" al hacer clic
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
              // Animación de Rive (invisible, pero onInit sigue funcionando)
              Opacity(
                opacity: 0.0, // Oculta la animación de Rive
                child: RiveAnimation.asset(
                  'assets/rive/menu_button.riv',
                  onInit: widget.riveOnInit,
                ),
              ),
              // Icono dinámico que alterna entre el menú y la "X"
              Icon(
                isMenuOpen ? Icons.close : Icons.menu, // Cambia entre el icono de menú y la "X"
                size: 30, // Tamaño del ícono
                color: isMenuOpen ? Colors.white : null, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
