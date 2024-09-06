import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InformativeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  final bool showNotification; // Bandera para mostrar notificación

  const InformativeCard({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
    this.showNotification = false, // Por defecto no se muestra
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color:
              Colors.white, // Fondo blanco para resaltar el borde y la sombra
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Sombra más visible
              blurRadius: 15, // Mayor difuminado de la sombra
              spreadRadius: 3, // Sombra extendida alrededor de la tarjeta
              offset: const Offset(
                  0, 5), // La sombra se extiende ligeramente hacia abajo
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
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: const Color(0xFF06065E), // Color del texto
                          fontWeight: FontWeight.bold,
                          fontSize: 16, 
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    count,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.black54,
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
                    color: const Color(0xFF06065E), // Color del ícono
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
                        color: const Color(0xFF06065E),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
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
