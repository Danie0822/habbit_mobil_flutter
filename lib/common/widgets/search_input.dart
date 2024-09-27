import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
// Entrada de búsqueda
class SearchInput extends StatelessWidget {
  // Cambio
  final ValueChanged<String>? onChanged;
  // Hint del texto
  final String? hintText;

  const SearchInput({super.key, this.onChanged, this.hintText});

  @override
  Widget build(BuildContext context) {
    // Define los colores según el tema.
    Color fillColor = ThemeUtils.getColorBasedOnBrightness(
        context, colorTextField, colorTextFieldDark);
    Color iconColor = ThemeUtils.getColorBasedOnBrightness(
        context, iconLightColor, iconDarkColor);
    // Diseño de la entrada de búsqueda
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: iconColor),
          filled: true,
          fillColor: fillColor,
          prefixIcon: Icon(Icons.search, color: iconColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),
    );
  }
}
