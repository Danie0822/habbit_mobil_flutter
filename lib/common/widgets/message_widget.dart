import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart'; 
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final bool readMessage;
  final String time;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.isSentByMe,
    required this.readMessage,
    required this.time,
  }) : super(key: key);

  String _formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    DateTime now = DateTime.now();

    if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
      return DateFormat('HH:mm').format(dateTime); // Mostrar solo la hora
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime); // Mostrar día, mes y año
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color mandado = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageLight, contenedorMensajeDark);

    final Color contestador = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageWidget, backgroundColor);
    
    final Color textoColor = ThemeUtils.getColorBasedOnBrightness(
        context, textColorNegro, lightTextColor);

    Color bgColor = isSentByMe ? mandado : contestador;
    Color textColor = isSentByMe ? textoColor : lightTextColor;

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.all(12.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDateTime(time),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                if (isSentByMe)
                  Icon(
                    readMessage ? Icons.done_all : Icons.done,
                    color: readMessage ? Colors.blue : Colors.grey,
                    size: 16.0,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
