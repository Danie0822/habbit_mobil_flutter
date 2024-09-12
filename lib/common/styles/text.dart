import 'package:flutter/material.dart';

class AppStyles {
  
  static TextStyle? headline6(BuildContext context, Color colorTexto) {
    final theme = Theme.of(context);
    return theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorTexto,
    );
  }
  static TextStyle? headlinee6(BuildContext context, Color colorTexto) {
    final theme = Theme.of(context);
    return theme.textTheme.titleLarge?.copyWith(
      color: colorTexto,
    );
  }
  static TextStyle? headline5(BuildContext context, Color colorTexto) {
    final theme = Theme.of(context);
    return theme.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorTexto,
    );
  }
  static TextStyle? subtitle1(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.titleMedium?.copyWith(
      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
      height: 1.5,
    );
  }
}

