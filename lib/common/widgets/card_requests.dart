import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/models/request_model.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class RequestsCards extends StatelessWidget {
  // Modelo de solicitud
  final RequestModel request;

  const RequestsCards({
    super.key,
    required this.request
  });

  @override
  Widget build(BuildContext context) {
    // Colores de los contenedores de mensaje
    final Color container = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);

    // Iconos y colores personalizados según el estado
    IconData icono;
    // Color del icono
    Color iconColor;
    // Color de fondo del icono
    Color iconBgColor;
    // Nombre del administrador
    final nombreAdmin = request.nombreAdministrador;
    // Fecha de la solicitud
    final fecha = request.fechaSolicitud; 
    // Cambiar el icono y el color según el estado de la solicitud
    switch (request.estadoSolicitud) {
      // Casos de estados de solicitudes
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
    // Diseño de la cards 
    return Container(
      // margen de 8 pixeles en la parte inferior
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      // decoración de la cards
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
      // fila de icono y texto
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
                  request.tituloSolicitud,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Administrador: $nombreAdmin',
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
          // Botón de edición de la solicitud cuando está en estado de revisión
          if (request.estadoSolicitud == 'Revisando')
            IconButton(
              icon: const Icon(
                Icons.edit,
                size: 20,
              ),
              onPressed: () {
                context.push('/updateRequest', extra: request); // Actualizar la solicitud 
              },
            ),
        ],
      ),
    );
  }
}
