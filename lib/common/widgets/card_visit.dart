import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class EventCard extends StatelessWidget {

  final String titulo;
  final String estado;
  final String fecha_inicio;

  const EventCard({
    super.key,
    required this.titulo,
    required this.estado,
    required this.fecha_inicio,
  });

  
  @override
  Widget build(BuildContext context) {
    
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
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColorAzul, 
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
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                backgroundColor: Colors.white, // Fondo blanco para el botón
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                elevation: 5,
              ),
              onPressed: () {
                // Acción del botón
              },
              child: const Icon(
                CupertinoIcons.arrow_right,
                color: Colors.blue, // Color del ícono de flecha
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
