import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     Color fillColor = ThemeUtils.getColorBasedOnBrightness(
        context, colorTextField, colorTextFieldDark);
    Color iconColor = ThemeUtils.getColorBasedOnBrightness(
        context, iconLightColor, iconDarkColor);
        
    return TextField(
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        height: 1.0,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: 'Search',
        hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey[400],
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: iconColor,
        ),
        border:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: iconColor),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: iconColor),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: iconColor),
        ),
      ),
    );
  }
}
