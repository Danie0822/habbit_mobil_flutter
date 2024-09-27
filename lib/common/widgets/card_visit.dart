// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class EventCard extends StatelessWidget {
  // Título del evento
  final String titulo;
  // Estado del evento
  final String estado;
  // Fecha de inicio del evento
  final String fecha_inicio;

  const EventCard({
    super.key,
    required this.titulo,
    required this.estado,
    required this.fecha_inicio,
  });

  
  @override
  Widget build(BuildContext context) {
    // Color de fondo del contenedor
      final Color container = ThemeUtils.getColorBasedOnBrightness(
      context, primaryColorAzul, contenedorMensajeDark);
    
    // Color de la chip del estado
    Color color;

    //Se cambia de color la chip del estado segun el mismo
    switch(estado){
      case 'Cancelada':
      color =  const Color(0xFFFF8585);
      break;
      case 'Pendiente':
      color = const Color(0xFFF7DC30);
      break;
      case 'Confirmada':
      color = const Color(0xFF5A9831);
      break;
      default:
      color = Colors.blueGrey;
    }

    // Diseño de la cards
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: container, 
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: color, 
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  estado,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Icon(
                CupertinoIcons.calendar,
                color: Colors.white,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                fecha_inicio,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
