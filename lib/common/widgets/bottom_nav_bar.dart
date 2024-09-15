import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors_menu.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Lista de íconos para las pestañas
  final iconList = <IconData>[
    Icons.home,
    Icons.message,
    Icons.home_repair_service_outlined,
    Icons.person,
  ];

  // Lista de etiquetas para las pestañas
  final labelList = <String>[
    'Inicio',
    'Mensajes',
    'Solicitudes',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    // Colores obtenidos según el tema y brillo actual
    Color backgroundColor = ThemeUtils.getColorBasedOnBrightness(
        context, lightBackgroundColor, darkBackgroundColor);
    Color shadowColor = ThemeUtils.getColorBasedOnBrightness(
        context, lightShadowColor, darkShadowColor);
    Color activeColor = ThemeUtils.getColorBasedOnBrightness(
        context, lightActiveColor, darkActiveColor);
    Color inactiveColor = ThemeUtils.getColorBasedOnBrightness(
        context, lightInactiveColor, darkInactiveColor);
    Color splashColor = ThemeUtils.getColorBasedOnBrightness(
        context, lightSplashColor, darkSplashColor);

    return Container(
      // Estilo de la barra de navegación inferior
      decoration: BoxDecoration(
        color: backgroundColor, // Color de fondo de la barra
        boxShadow: [
          BoxShadow(
            color: shadowColor, 
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length, // Cantidad de íconos en la barra
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? activeColor : inactiveColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index], // Ícono según el índice
                size: 28,
                color: color,
              ),
              if (isActive) // Mostrar etiqueta solo si la pestaña está activa
                Text(
                  labelList[index], // Etiqueta según el índice
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                  ),
                ),
            ],
          );
        },
        activeIndex: widget.currentIndex, 
        gapLocation: GapLocation.none, 
        notchSmoothness: NotchSmoothness.verySmoothEdge, 
        onTap: widget.onTap, 
        backgroundColor: backgroundColor, 
        splashColor: splashColor, 
        height: 70, 
      ),
    );
  }
}
