import 'package:flutter/material.dart';

 Widget buildFilter(String text, bool isSelected, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.grey[850],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.grey[400]),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[400],
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }