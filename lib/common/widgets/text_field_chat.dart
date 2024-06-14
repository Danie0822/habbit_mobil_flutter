import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final IconData icon;
  final TextEditingController? controller;
  final VoidCallback? onClearPressed;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  const MyTextField({
    Key? key,
    required this.hint,
    required this.isPassword,
    required this.icon,
    this.controller,
    this.onClearPressed,
    this.onChanged,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color fillColor = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[200]!
        : Colors.grey[700]!;
    Color iconColor = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[600]!
        : Colors.grey[300]!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8.0),
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
        onChanged: onChanged,
        maxLines: 5, // Máximo de 5 líneas
        minLines: 1, // Mínimo de 1 línea
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
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
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: fillColor,
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
      ),
    );
  }
}
