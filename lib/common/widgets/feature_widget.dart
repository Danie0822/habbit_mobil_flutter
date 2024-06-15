import 'package:flutter/material.dart';


Widget buildFeature(IconData iconData, String text) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: Colors.blueAccent [700],
          size: 28,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    ],
  );
}
