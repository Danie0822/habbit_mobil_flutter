import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

// Área de texto personalizada
class MyTextArea extends StatelessWidget {
  const MyTextArea({
    Key? key,
    required this.hint,
    required this.icon,
    required this.context,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.inputFormatters,
    this.keyboardType,
    this.maxLines = 2, // Máximo de líneas por defecto
  }) : super(key: key);

  // Campos de texto
  final String hint;
  // Icon 
  final IconData icon;
  // context
  final BuildContext context;
  // contolador
  final TextEditingController? controller;
  // Validor
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int maxLines;
  // Colores de los campos de texto
  @override
  Widget build(BuildContext context) {
    Color fillColor = ThemeUtils.getColorBasedOnBrightness(
        context, colorTextField, colorTextFieldDark);

    Color iconColor = ThemeUtils.getColorBasedOnBrightness(
        context, iconLightColor, iconDarkColor);
    // Contenedor de área de texto
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        inputFormatters: inputFormatters ?? [],
        keyboardType: keyboardType,
        maxLines: maxLines, // Permitimos múltiples líneas
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[500]!,
            fontSize: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 2), // Ajuste vertical y horizontal
            child: Icon(icon, color: iconColor),
          ),
          suffixIcon: suffixIcon != null
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: suffixIcon,
                )
              : null,
          filled: true,
          fillColor: fillColor,
          errorMaxLines: 3,
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
