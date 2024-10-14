// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart'; 
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  // Mensaje
  final String message;
  // Si es mandado por el usuario
  final bool isSentByMe;
  // Leido
  final bool readMessage;
  // Tiempo
  final String time;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.isSentByMe,
    required this.readMessage,
    required this.time,
  }) : super(key: key);

  // Formatea la fecha y la hora del mensaje
  String _formatDateTime(String dateTimeStr) {
    try {
      // Parsea la fecha y la hora
      DateTime dateTime = DateTime.parse(dateTimeStr);
      DateTime now = DateTime.now();

      // Si el mensaje es del mismo día, mostrar solo la hora
      if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
        return DateFormat('HH:mm').format(dateTime); // Mostrar solo la hora
      } else {
        // Si el mensaje no es del mismo día, mostrar día, mes y año
        return DateFormat('dd/MM/yyyy').format(dateTime); // Mostrar día, mes y año
      }
    } catch (error) {
      return dateTimeStr; // En caso de error, retorna el string original
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      //Definicion de los colores 
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
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDateTime(time),
                    style: const TextStyle(
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
    } catch (error) {
      return Container(); // Retorna un contenedor vacío en caso de error
    }
  }
}
