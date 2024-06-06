import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = Theme.of(context).colorScheme.primary;
    final Color textColor = Theme.of(context).colorScheme.onPrimary;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width, 50),
          padding: const EdgeInsets.symmetric(vertical: 0),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
