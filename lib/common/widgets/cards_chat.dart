import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class ChatCard extends StatelessWidget {
  // ID de la conversación
  final int idConversacion;
  // Título de la conversación
  final String title;
  // Nombre del usuario
  final String name;
  // Mensaje
  final String message;
  // Hora del mensaje
  final String time;
  // URL de la imagen
  final String imageUrl;
  // Indica si el mensaje ha sido leído
  final bool isRead;
  // Indica si el usuario es administrador
  final bool isAdmin;

  const ChatCard({
    required this.idConversacion,
    required this.title,
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    required this.isRead,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    // Ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    // tamaño de fuente de titulo
    double titleFontSize = screenWidth * 0.05;
    // tamaño de fuente de mensaje
    double messageFontSize = screenWidth * 0.035;
    // tamaño de fuente de nombre
    double nameFontSize = screenWidth * 0.04;
    // tamaño de fuente de hora
    double timeFontSize = screenWidth * 0.03;

    // Color de fondo del contenedor
    final Color containerMessage = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);
    // Color del texto
    final Color textName = ThemeUtils.getColorBasedOnBrightness(
        context, textColorNegro, lightTextColor);

    // Formatear la fecha
    String formattedDate = 'Fecha inválida';
    try {
      // Si la fecha no está vacía
      if (time.isNotEmpty) {
        // Parsear la fecha
        DateTime parsedDate = DateTime.parse(time);
        // Formatear la fecha
        formattedDate =
            '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}';
      }
    } catch (e) {
      print('Error parsing date: $e');
    }

    // Truncar el título y el mensaje
    String truncatedTitle =
        title.length > 18 ? '${title.substring(0, 18)}...' : title;
    // Truncar el mensaje
    String truncatedMessage =
        message.length > 30 ? '${message.substring(0, 30)}...' : message;

    // Tarjeta de chat
    return GestureDetector(
      onTap: () {
        context.push('/chat', extra: {
          'idConversacion': idConversacion,
          'nameUser': name,
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: containerMessage,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: textName.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _buildImage(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            truncatedTitle,
                            style: TextStyle(
                              color: textName,
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.3, // Adjust width as needed
                          child: Text(
                            formattedDate,
                            style: TextStyle(
                              color: textName,
                              fontSize: timeFontSize,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      name,
                      style: TextStyle(
                        color: textName,
                        fontSize: nameFontSize,
                        fontWeight: !isRead && isAdmin
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            isAdmin ? '$name: $truncatedMessage' : truncatedMessage,
                            style: TextStyle(
                              color: textName,
                              fontSize: messageFontSize,
                              fontWeight: !isRead && isAdmin
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          isRead ? Icons.done_all : Icons.check,
                          color: isRead ? Colors.blue : Colors.grey,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Construir imagen
  Widget _buildImage() {
    try {
      if (imageUrl.isNotEmpty) {
        return Image.network(
          imageUrl,
          width: 75,
          height: 75,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('Error loading image: $error');
            return _defaultIcon();
          },
        );
      }
    } catch (e) {
      print('Exception loading image: $e');
    }
    return _defaultIcon();
  }
  // Icono por defecto
  Widget _defaultIcon() {
    return const Icon(
      Icons.account_circle,
      size: 75,
      color: Colors.grey,
    );
  }
}
