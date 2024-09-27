import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors_menu.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class CustomAlertDialogAcceptCancel extends StatelessWidget {
  // Título de la alerta
  final String title;
  // Mensaje de la alerta
  final String message;
  // Tipo de alerta
  final int type;
  // Función al aceptar
  final void Function() onAccept;
  // Función al cancelar
  final void Function() onCancel;

  const CustomAlertDialogAcceptCancel({
    required this.title,
    required this.message,
    required this.type,
    required this.onAccept,
    required this.onCancel,
    super.key,
  });

  // Icono de la alerta según el tipo
  IconData _getIcon() {
    switch (type) {
      case 1:
        return Icons.warning_amber_rounded;
      case 2:
        return Icons.error_outline_rounded;
      case 3:
        return Icons.check_circle_outline_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  // Color de la alerta según el tipo
  Color _getColor() {
    switch (type) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.red;
      case 3:
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = ThemeUtils.getColorBasedOnBrightness(
        context, lightBackgroundColor, darkBackgroundColor);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Encabezado con el icono y el título
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _getColor().withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getIcon(),
                      color: _getColor(),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/logoLight.png', // Ruta al logo
                    height: 40,
                  ),
                ],
              ),
            ),
            // Cuerpo con el mensaje
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    textAlign: TextAlign.center, // Centrar el mensaje
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  // Botones de cancelar y aceptar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        onPressed: onCancel,
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        onPressed: onAccept,
                        child: const Text(
                          "Aceptar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Mostrar alerta con botón de aceptar y cancelar
Future<bool?> showAlertDialogAcceptCancel(
  String title,
  String message,
  int type,
  BuildContext context,
  void Function() onAccept,
  void Function() onCancel,
) {
  // Mostrar la alerta
  return showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialogAcceptCancel(
        title: title,
        message: message,
        type: type,
        onAccept: () {
          onAccept();
        },
        onCancel: () {
          onCancel();
        },
      );
    },
  );
}

