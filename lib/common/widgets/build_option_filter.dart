import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart'; 
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart'; 

Widget buildCategoryOption(String category, context, String selectedCategory, void Function(String) onSelected) {
  // Obtiene el color del texto basado en el brillo del tema
  Color textColorText = ThemeUtils.getColorBasedOnBrightness(context, textColor, lightTextColor);
  // Determina si la categoría está seleccionada comparando con la categoría seleccionada actualmente
  bool selected = category == selectedCategory;

  return GestureDetector(
    onTap: () {
      onSelected(category); // Llama a la función de selección cuando se toca la opción
    },
    child: Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : Colors.transparent, // Color de fondo basado en si está seleccionado
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: selected ? Theme.of(context).primaryColor : Colors.grey, // Color del borde basado en si está seleccionado
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
            color: selected ? Colors.white : textColorText, // Color del texto basado en si está seleccionado
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

// Método para construir una opción de zona
Widget buildZoneOption(String zone, context, String selectedZone, void Function(String) onSelected) {
  // Obtiene el color del texto basado en el brillo del tema
  Color textColorText = ThemeUtils.getColorBasedOnBrightness(context, textColor, lightTextColor);
  // Determina si la zona está seleccionada comparando con la zona seleccionada actualmente
  bool selected = zone == selectedZone;

  return GestureDetector(
    onTap: () {
      onSelected(zone); // Llama a la función de selección cuando se toca la opción
    },
    child: Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : Colors.transparent, 
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: selected ? Theme.of(context).primaryColor : Colors.grey, 
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          zone,
          style: TextStyle(
            color: selected ? Colors.white : textColorText, 
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
