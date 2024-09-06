import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

// Cards que muestran las solicitudes de los usuarios
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
    // Cambio de color de fondo de acuerdo al tema
    final Color container = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);

    // Dependiendo del estado se visualiza un icono y color diferente
    IconData cardIcon;
    Color iconColor;
    Color borderColor;
    // Asignación de icono y color dependiendo del estado
    switch (estado) {
      case 'Revisando':
        cardIcon = Icons.hourglass_top;
        iconColor = Colors.orange;
        borderColor = Colors.orangeAccent;
        break;
      case 'Rechazada':
        cardIcon = Icons.cancel;
        iconColor = Colors.red;
        borderColor = Colors.redAccent;
        break;
      case 'Aceptada':
        cardIcon = Icons.check_circle;
        iconColor = Colors.green;
        borderColor = Colors.greenAccent;
        break;
      default:
        cardIcon = Icons.help_outline;
        iconColor = Colors.blueGrey;
        borderColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: container,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(
              cardIcon,
              size: 32,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Administrador: $administrador', // Se muestra el administrador
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Fecha: $fecha', // Se muestra la fecha
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
