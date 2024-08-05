import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class ChatCard extends StatelessWidget {
  final String title;
  final String name;
  final String message;
  final String time;
  final String imageUrl;
  final bool isRead;
  final bool isAdmin;

  const ChatCard({
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
    final Color containerMessage = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);

    final Color textName = ThemeUtils.getColorBasedOnBrightness(
        context, textColorNegro, lightTextColor);

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

    String truncatedTitle =
        title.length > 18 ? '${title.substring(0, 18)}...' : title;
    String truncatedMessage =
        message.length > 30 ? '${message.substring(0, 30)}...' : message;

    String truncatedMessageName =
    '$name: $truncatedMessage'.length > 30 ? '${'$name: $truncatedMessage'.substring(0, 30)}...' : '$name: $truncatedMessage';

    return GestureDetector(
      onTap: () {
        context.push('/chat');
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: containerMessage,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 75,
                        color: textName,
                      ),
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(color: textName),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      name,
                      style: TextStyle(
                        color: textName,
                        fontSize: 14,
                        fontWeight:
                            isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        if (isAdmin)
                          Expanded(
                            child: Text(
                              truncatedMessageName,
                              style: TextStyle(
                                color: textName,
                                fontWeight: isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: Text(
                              truncatedMessage,
                              style: TextStyle(
                                color: textName,
                                fontWeight: isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                          ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.check,
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
}
