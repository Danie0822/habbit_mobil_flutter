import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/theme/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.hint,
    required this.isPassword,
    required this.icon, required BuildContext context,
  }) : super(key: key);

  final String hint;
  final bool isPassword;
  final IconData icon;

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
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[500]!,
            fontSize: 16,
          ),
          prefixIcon: Icon(icon, color: iconColor),
          filled: true,
          fillColor: fillColor,
        ),
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
      ),
    );
  }
}
