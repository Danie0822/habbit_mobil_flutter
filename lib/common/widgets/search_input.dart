import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    // Define los colores según el tema.
    Color fillColor = ThemeUtils.getColorBasedOnBrightness(
        context, colorTextField, colorTextFieldDark);
    Color iconColor = ThemeUtils.getColorBasedOnBrightness(
        context, iconLightColor, iconDarkColor);

    return Padding(
      padding: const EdgeInsets.only(top: 20.0), 
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar...',
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
