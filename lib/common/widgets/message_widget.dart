import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart'; // Asegúrate de importar tu archivo de temas
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.isSentByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = isSentByMe ? contenedorMensajeLight : backgroundColor;
    Color textColor = isSentByMe ? textColorNegro : lightTextColor;

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
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
        child: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
