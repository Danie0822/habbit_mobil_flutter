import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class ChatCard extends StatelessWidget {
  final int idConversacion;
  final String title;
  final String name;
  final String message;
  final String time;
  final String imageUrl;
  final bool isRead;
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
    // Tamaños responsivos basados en el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.05; // Ajuste dinámico para el título
    double messageFontSize = screenWidth * 0.035; // Ajuste para el mensaje
    double nameFontSize = screenWidth * 0.04; // Ajuste para el nombre
    double timeFontSize = screenWidth * 0.03; // Ajuste para la hora

    // Colores dinámicos basados en el tema
    final Color containerMessage = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);
    final Color textName = ThemeUtils.getColorBasedOnBrightness(
        context, textColorNegro, lightTextColor);

    // Formatear la fecha
    String formattedDate = 'Fecha inválida';
    try {
      if (time.isNotEmpty) {
        DateTime parsedDate = DateTime.parse(time);
        formattedDate =
            '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
      }
    } catch (e) {
      print('Error parsing date: $e');
    }

    // Truncar título y mensaje
    String truncatedTitle =
        title.length > 18 ? '${title.substring(0, 18)}...' : title;
    String truncatedMessage =
        message.length > 30 ? '${message.substring(0, 30)}...' : message;

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
                        Text(
                          truncatedTitle,
                          style: TextStyle(
                            color: textName,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            color: textName,
                            fontSize: timeFontSize,
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

  Widget _defaultIcon() {
    return const Icon(
      Icons.account_circle,
      size: 75,
      color: Colors.grey,
    );
  }
}
