import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/theme/colors.dart';


// Common text theme
const TextTheme textTheme = TextTheme(
  bodyLarge: TextStyle(color: textColor),
  bodyMedium: TextStyle(color: textColor),
);

// Light theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: whiteColor,
  hintColor: accentColor,
  textTheme: textTheme.copyWith(
    bodyLarge: textTheme.bodyLarge?.copyWith(color: textColor),
    bodyMedium: textTheme.bodyMedium?.copyWith(color: textColor),
    headlineLarge: const TextStyle(color: colorTextPrimaryLight),
    headlineMedium: const TextStyle(color: colorTextSecondaryLight),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: secondaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  iconTheme: const IconThemeData(color: iconLightColor),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: colorTextField,
    hintStyle: const TextStyle(color: textColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: primaryColor),
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    background: whiteColor,
    surface: whiteColor,
    onPrimary: whiteColor,
    onSecondary: whiteColor,
    onBackground: textColor,
    onSurface: textColor,
  ),
);

// Dark theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryDarkColor,
  scaffoldBackgroundColor: almostBlackColor,
  hintColor: accentDarkColor,
  textTheme: textTheme.copyWith(
    bodyLarge: textTheme.bodyLarge?.copyWith(color: lightTextColor),
    bodyMedium: textTheme.bodyMedium?.copyWith(color: lightTextColor),
    headlineLarge: const TextStyle(color: colorTextPrimaryDark),
    headlineMedium: const TextStyle(color: colorTextSecondaryDark),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: darkSecondaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  iconTheme: const IconThemeData(color: iconDarkColor),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: colorTextFieldDark,
    hintStyle: const TextStyle(color: lightTextColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: primaryDarkColor),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: primaryDarkColor,
    secondary: darkSecondaryColor,
    background: backgroundColor,
    surface: backgroundColor,
    onPrimary: lightTextColor,
    onSecondary: lightTextColor,
    onBackground: lightTextColor,
    onSurface: lightTextColor,
  ),
);
