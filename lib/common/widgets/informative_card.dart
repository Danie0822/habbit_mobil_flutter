// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class InformativeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  final bool showNotification; // Bandera para mostrar notificacións

  const InformativeCard({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    this.showNotification = false, // Por defecto no se muestra
  });

  @override
  Widget build(BuildContext context) {
    
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? Colors.black.withOpacity(0.2)
        : contenedorMensajeDark;

    final Color backgroundColor = Theme.of(context).brightness == Brightness.light
        ? colorTextField
        : contenedorMensajeDark;
    
    final Color colorTextoTitulo = Theme.of(context).brightness == Brightness.light
        ? const Color(0xFF06065E)
        : colorTextField;
    
    final Color colorTextoSub = Theme.of(context).brightness == Brightness.light
        ? Colors.black54
        : contenedorMensajeLight;

    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color:backgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: colorTexto,
              blurRadius: 5, 
              spreadRadius: 4, 
              offset: const Offset(0, 5),            
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorTextoTitulo, // Color del texto
                          fontWeight: FontWeight.bold,
                          fontSize: 16, 
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    count,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorTextoSub,
                          fontSize: 14, 
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 28,
                  child: Icon(
                    icon,
                    color: colorTextoTitulo, // Color del ícono
                    size: 45,
                  ),
                ),
                if (showNotification)
                  Positioned(
                    right: 10,
                    top: 8,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colorTextoTitulo,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: backgroundColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
