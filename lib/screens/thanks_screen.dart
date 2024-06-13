import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class thankScreen extends StatelessWidget {
  const thankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Text(
          "¡Muchas gracias por contestar!",
          style: AppStyles.headline5(context, colorTexto),
        ),
        const SizedBox(height: 10),
        Text(
          "Con cada respuesta tuya nos ayudas a mostrarte propiedades que te puedan interesar.",
          style: AppStyles.subtitle1(context),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: CustomButton(
            onPressed: () {
              context.push('/ubi');
            },
            text: "Crear cuenta",
          ),
        ),
      ]),
    ));
  }
}
