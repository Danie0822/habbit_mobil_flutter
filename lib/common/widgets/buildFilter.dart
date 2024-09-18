import 'package:flutter/material.dart';
 // filtro de busqueda de propiedades 
 Widget buildFilter(String text, bool isSelected, IconData icon, BuildContext context) {
    return Padding( 
      // padding de 8 pixeles a la derecha
      padding: const EdgeInsets.only(right: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[420],
          borderRadius: BorderRadius.circular(20),
        ),
        // fila de icono y texto
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