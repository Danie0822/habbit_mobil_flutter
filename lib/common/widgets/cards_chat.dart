import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:go_router/go_router.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const ChatCard({
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final Color containerMessage = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);

    final Color textName = ThemeUtils.getColorBasedOnBrightness(
        context, textColorNegro, lightTextColor);
    return GestureDetector(
      onTap: () {
        context.push('/chat');
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          alignment: Alignment.center,
          height: 100,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: textName,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(color: textName),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                message,
                style: TextStyle(color: textName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
