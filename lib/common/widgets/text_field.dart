import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

// Campo de texto personalizado
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
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);
  // Campos de texto
  final String hint;
  // si es contraseña
  final bool isPassword;
  // ICON
  final IconData icon;
  final BuildContext context;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    // Obtener el color del campo de acuerdo con el tema y la luminosidad
    Color fillColor = ThemeUtils.getColorBasedOnBrightness(
        context, colorTextField, colorTextFieldDark);

    // Obtener el color del icono de acuerdo con el tema y la luminosidad
    Color iconColor = ThemeUtils.getColorBasedOnBrightness(
        context, iconLightColor, iconDarkColor);

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
        inputFormatters: inputFormatters ?? [],
        keyboardType: keyboardType,
        maxLines: 1, // Limitar a una sola línea
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
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
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
          errorMaxLines: 3, // Permite hasta 3 líneas para el mensaje de error
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
