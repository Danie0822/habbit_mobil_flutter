import 'package:flutter/material.dart';

class AppStyles {
  
  static TextStyle? headline6(BuildContext context, Color colorTexto) {
    final theme = Theme.of(context);
    return theme.textTheme.headline6?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorTexto,
    );
  }
  static TextStyle? headlinee6(BuildContext context, Color colorTexto) {
    final theme = Theme.of(context);
    return theme.textTheme.headline6?.copyWith(
      color: colorTexto,
    );
  }
  static TextStyle? headline5(BuildContext context, Color colorTexto) {
    final theme = Theme.of(context);
    return theme.textTheme.headline4?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorTexto,
    );
  }
  static TextStyle? subtitle1(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.subtitle1?.copyWith(
      color: theme.textTheme.bodyText2?.color?.withOpacity(0.6),
      height: 1.5,
    );
  }
}

