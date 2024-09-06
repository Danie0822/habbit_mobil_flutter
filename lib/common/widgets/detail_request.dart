import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/data/models/request_model.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

// Diseño de detalles de las solicitudes
Widget DetailRequest(BuildContext context, RequestModel request) {
  final Color container = ThemeUtils.getColorBasedOnBrightness(
      context, contenedorMensajeLight, contenedorMensajeDark);
  
  // Diálogo que muestra los detalles de la solicitud
  return Dialog(
    backgroundColor: Colors.transparent,
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
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.tituloSolicitud,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 12),
                // Construir las tarjetas de detalles
                ..._buildDetailCards(request),
                const SizedBox(height: 16),
                // Añadir el botón de cierre en la parte inferior del contenido
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      backgroundColor: Colors.grey[300],
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
        ],
      ),
    ),
  );
}

// Construir las tarjetas de detalles de la solicitud con la información de la solicitud
List<Widget> _buildDetailCards(RequestModel request) {
  return [
    _DetailCard(
        icon: Icons.person,
        label: 'Administrador',
        value: request.nombreAdministrador),
    _DetailCard(
        icon: Icons.calendar_today,
        label: 'Fecha',
        value: request.fechaSolicitud),
    _DetailCard(
        icon: Icons.info,
        label: 'Estado',
        value: request.estadoSolicitud,
        color: _getStatusColor(request.estadoSolicitud)),
    _DetailCard(
        icon: Icons.category,
        label: 'Categoría',
        value: request.nombreCategoria),
    _DetailCard(
        icon: Icons.location_on, label: 'Zona', value: request.nombreZona),
    _DetailCard(
        icon: Icons.home,
        label: 'Dirección',
        value: request.direccionPropiedad),
    _DetailCard(
        icon: Icons.money,
        label: 'Precio Casa',
        value: '\$${request.precioCasa}'),
    _DetailCard(
        icon: Icons.monetization_on,
        label: 'Ganancia Empresa',
        value: '\$${request.gananciaEmpresa}'),
    _DetailCard(
        icon: Icons.lock,
        label: 'Exclusividad',
        value: request.exclusividadComercializacion),
  ];
}

// Obtener el color del estado de la solicitud
Color _getStatusColor(String status) {
  switch (status) {
    case 'Revisando':
      return Colors.orangeAccent;
    case 'Rechazada':
      return Colors.redAccent;
    case 'Aceptada':
      return Colors.greenAccent;
    default:
      return Colors.blueGrey;
  }
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
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color ?? Colors.blueAccent, size: 26),
          const SizedBox(width: 16), // Mayor separación para visual más limpio
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label:',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5, // Espaciado de líneas para mejor lectura
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
