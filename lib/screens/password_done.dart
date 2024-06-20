import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:lottie/lottie.dart';

import '../common/widgets/button_2.dart';

class PasswordDone extends StatelessWidget {
  const PasswordDone({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final verticalPadding = screenWidth < 600 ? 16.0 : 32.0;
    final textFontSize = screenWidth < 600 ? 16.0 : 20.0;
    final headingFontSize = screenWidth < 600 ? 30.0 : 40.0;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(verticalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Restablecimiento exitoso',
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: colorTextSecondaryLight,
                ),
              ),
             const SizedBox(height: 16),
              Text(
                'Tu contraseña ha sido restablecida con éxito. Ahora puedes usar tu nueva contraseña para iniciar sesión.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textFontSize, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: screenWidth * 0.8,
                height: screenWidth * 0.8,
                child: Lottie.network(
                  "https://lottie.host/db1ab1ca-5c14-440f-85e1-6c0f352586d7/ceNVRPZRYQ.json",
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                onPressed: () {
                  context.push('/login');
                },
                text: "Regresar",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
