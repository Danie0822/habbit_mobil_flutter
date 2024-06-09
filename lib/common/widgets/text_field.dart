import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.hint,
    required this.isPassword,
    required this.icon,
    required this.context,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.inputFormatters, // Añadido para permitir inputFormatters personalizados
  }) : super(key: key);

  final String hint;
  final bool isPassword;
  final IconData icon;
  final BuildContext context;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters; // Añadido para permitir inputFormatters personalizados

  @override
  Widget build(BuildContext context) {
    final Color fillColor = Theme.of(context).brightness == Brightness.light ? colorTextField : colorTextFieldDark;
    final Color iconColor = Theme.of(context).brightness == Brightness.light ? iconLightColor : iconDarkColor;

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
        obscureText: isPassword,
        validator: validator,
        inputFormatters: inputFormatters ?? [], // Si no se proporcionan inputFormatters, se usa una lista vacía
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[500]!,
            fontSize: 16,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: iconColor),
          ),
          suffixIcon: suffixIcon != null ? Container(
            padding: const EdgeInsets.all(12),
            child: suffixIcon,
          ) : null,
          filled: true,
          fillColor: fillColor,
        ),
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
      ),
    );
  }
}
