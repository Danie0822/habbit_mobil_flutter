import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:lottie/lottie.dart';

import '../common/widgets/button_2.dart';

class PasswordDone extends StatelessWidget {
  const PasswordDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Restablecimiento exitoso',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: colorTextSecondaryLight),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tu contraseña ha sido restablecida con éxito. Ahora puedes usar tu nueva contraseña para iniciar sesión.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 300,
                height: 300,
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
