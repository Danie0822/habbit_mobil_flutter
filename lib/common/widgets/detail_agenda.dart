import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/data/models/visits_model.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:intl/intl.dart';

// Diseño de detalles de las solicitudes
Widget DetailAgenda(BuildContext context, VisitModel visit) {
  final Color container = ThemeUtils.getColorBasedOnBrightness(
      context, primaryColor, contenedorMensajeDark);

  // Diálogo que muestra los detalles de la solicitud
  return Dialog(
  backgroundColor: Colors.transparent,
  child: SingleChildScrollView(  // Envuelve el contenido del diálogo
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: container,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            visit.tituloVisita,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
            softWrap: true,
            maxLines: null,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: 12),
          // Construir las tarjetas de detalles
          ..._buildDetailCards(visit),
          const SizedBox(height: 16),
          // Botón de cerrar alineado al centro en la parte inferior
          Align(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cerrar',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    ),
  ),
);

}

// Función para formatear la fecha
String formatFecha(DateTime fecha) {
  return DateFormat('d \'de\' MMMM \'de\' yyyy, h:mm a', 'es_ES')
      .format(fecha.toLocal());
}

// Construir las tarjetas de detalles de la solicitud con la información de la solicitud
List<Widget> _buildDetailCards(VisitModel visit) {
  return [
    _DetailCard(
      icon: Icons.calendar_today,
      label: 'Inicio',
      value: formatFecha(visit.fechaHoraInicio),
    ),
    _DetailCard(
      icon: Icons.calendar_today,
      label: 'Finalización',
      value: formatFecha(visit.fechaHoraFinalizacion),
    ),
    _DetailCard(
      icon: Icons.hourglass_empty,
      label: 'Estado',
      value: visit.estadoVisita,
    ),
    _DetailCard(
      icon: Icons.person,
      label: 'Agente',
      value: visit.nombreAdmin,
    ),
  ];
}

// Tarjeta de detalles de la solicitud
class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _DetailCard({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Añadir ícono al lado izquierdo
          Icon(icon, color: color ?? Colors.white, size: 20),
          const SizedBox(width: 16), // Espaciado entre ícono y texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label:',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5, 
                    color: Colors.white,
                  ),
                  maxLines: 3,
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
