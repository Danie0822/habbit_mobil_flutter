import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/search_input.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class HeaderScreen extends StatelessWidget {
  // Indica si el campo de búsqueda es visible
  final bool isSearchVisible;
  // Función para alternar la visibilidad del campo de búsqueda
  final VoidCallback onSearchToggle;
  // Animación de desplazamiento
  final Animation<Offset> offsetAnimation;
  // Función para cambiar el texto de búsqueda
  final Function(String) onSearchChanged;
  // Texto de ayuda del campo de búsqueda
  final String hintTextt;
  // Título de la pantalla
  final String titleHeader;
  // Color de fondo
  final Color backgroundColor;
  // Altura del SizedBox
  final double sizedBoxHeight;

  const HeaderScreen({
    Key? key,
    required this.isSearchVisible,
    required this.onSearchToggle,
    required this.offsetAnimation,
    required this.onSearchChanged,
    required this.hintTextt,
    required this.titleHeader,
    this.backgroundColor = colorBackGroundMessage,
    this.sizedBoxHeight = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Permite que los elementos se salgan del stack
      children: [
        // Container azul superior
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            children: [
              SizedBox(height: sizedBoxHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleHeader,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: whiteColor,
                    ),
                  ),
                  IconButton(
                    onPressed: onSearchToggle,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return RotationTransition(
                          turns: child.key == const ValueKey('search')
                              ? animation
                              : Tween<double>(begin: 1, end: 0.75)
                                  .animate(animation),
                          child: FadeTransition(opacity: animation, child: child),
                        );
                      },
                      child: Icon(
                        isSearchVisible ? Icons.close : Icons.search,
                        key: ValueKey(isSearchVisible ? 'close' : 'search'),
                        color: whiteColor,
                        size: 25.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (isSearchVisible)
                SlideTransition(
                  position: offsetAnimation,
                  child: SearchInput(
                    onChanged: onSearchChanged,
                    hintText: hintTextt,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
