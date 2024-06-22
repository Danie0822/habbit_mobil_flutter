import 'package:flutter/material.dart';

// Clase para manejar colores basados en el tema
class ThemeUtils {
  // Devuelve un color según el tema (claro u oscuro)
  static Color getColorBasedOnBrightness(BuildContext context, Color lightColor, Color darkColor) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightColor : darkColor;
  }

  // Devuelve un colors según el tema (claro u oscuro)
  static Colors getColosrBasedOnBrightness(BuildContext context, Colors lightColor, Colors darkColor) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightColor : darkColor;
  }
}
