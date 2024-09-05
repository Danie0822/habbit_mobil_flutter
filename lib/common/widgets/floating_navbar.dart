import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  FloatingNavBar({super.key, required this.currentIndex, required this.onTap});

  final List<IconData> iconList = [Icons.map, Icons.recommend];
  final List<String> labelList = ['Descubre', 'Recomendado'];

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : Colors.grey[900]!;
    Color activeColor = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;
    Color inactiveColor = Colors.grey;

    // Ajustamos el ancho y el espaciado para evitar el desbordamiento
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 60, 
            left: MediaQuery.of(context).size.width * 0.2, 
            right: MediaQuery.of(context).size.width * 0.2, 
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(iconList.length * 2 - 1, (index) {
                  if (index % 2 == 1) {
                    // Si el índice es impar, añadimos la barra de separación
                    return Container(
                      width: 3, 
                      height: 30, 
                      color: secondaryColor, 
                    );
                  }

                  // Para los índices pares, renderizamos los íconos y los textos
                  int iconIndex = index ~/ 2;
                  final isActive = currentIndex == iconIndex;
                  final color = isActive ? activeColor : inactiveColor;

                  return GestureDetector(
                    onTap: () => onTap(iconIndex),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            iconList[iconIndex],
                            size: isActive ? 30 : 24, 
                            color: color,
                          ),
                          if (isActive)
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0), 
                              child: Text(
                                labelList[iconIndex],
                                overflow: TextOverflow.ellipsis, 
                                style: TextStyle(
                                  color: color,
                                  fontSize: 14, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
