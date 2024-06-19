import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/button_2.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:lottie/lottie.dart';

class CodeView extends StatelessWidget {
  const CodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                  "https://lottie.host/94694577-8cf3-4fd1-96a0-aca85b318bc9/lL7IY9NZCI.json"),
              const SizedBox(height: 24),
              const Text(
                'Verifica tu correo',
                style: TextStyle(
                  color: colorTextSecondaryLight,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Por favor, introduzca el código de 4 dígitos enviado a pixeltoonss@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  // Handle resend code action
                },
                child: const Text(
                  'Reenviar código',
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: () {
                  context.push('/pass');
                },
                text: "Verificar",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
