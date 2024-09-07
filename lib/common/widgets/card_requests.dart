import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

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
    final Color container = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);
    // Iconos y colores personalizados según el estado
    IconData icono;
    Color iconColor;
    Color iconBgColor;
    switch (estado) {
      case 'Revisando':
        icono = Icons.hourglass_top;
        iconColor = Colors.orangeAccent;
        iconBgColor = Colors.orange.withOpacity(0.2);
        break;
      case 'Rechazada':
        icono = Icons.cancel;
        iconColor = Colors.redAccent;
        iconBgColor = Colors.red.withOpacity(0.2);
        break;
      case 'Aceptada':
        icono = Icons.check_circle;
        iconColor = Colors.greenAccent;
        iconBgColor = Colors.green.withOpacity(0.2);
        break;
      default:
        icono = Icons.help_outline;
        iconColor = Colors.grey;
        iconBgColor = Colors.grey.withOpacity(0.2);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: container,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icono,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Administrador: $administrador',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Fecha: $fecha',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
