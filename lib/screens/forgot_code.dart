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
              const CodeInputFields(),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
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

class CodeInputFields extends StatelessWidget {
  const CodeInputFields({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CodeInputField(),
        CodeInputField(),
        CodeInputField(),
        CodeInputField(),
      ],
    );
  }
}

class CodeInputField extends StatelessWidget {
  const CodeInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          letterSpacing: 2.0,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none, // Sin borde
          ),
          filled: true,
          fillColor: Colors.grey[850],
          counterText: '',
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
