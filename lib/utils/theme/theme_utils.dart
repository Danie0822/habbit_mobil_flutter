import 'package:flutter/material.dart';

class ThemeUtils {
  static Color getColorBasedOnBrightness(BuildContext context, Color lightColor, Color darkColor) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightColor : darkColor;
  }
    static Colors getColosrBasedOnBrightness(BuildContext context, Colors lightColor, Colors darkColor) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightColor : darkColor;
  }
}
