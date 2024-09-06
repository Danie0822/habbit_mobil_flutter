import 'package:flutter/material.dart';

class RequestsCards extends StatelessWidget {
  final String titulo;
  final String administrador;
  final String fecha;
  final String estado;

  const RequestsCards({
    super.key,
    required this.titulo,
    required this.administrador,
    required this.fecha,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {
    // Dependiendo del estado se visualiza un color diferente
    Color cardColor;
    switch (estado) {
      case 'Revisando':
        cardColor = Colors.orangeAccent;
        break;
      case 'Rechazada':
        cardColor = Colors.redAccent;
        break;
      case 'Aceptada':
        cardColor = Colors.greenAccent;
        break;
      default:
        cardColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.assignment,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Administrador: $administrador',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fecha: $fecha',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
