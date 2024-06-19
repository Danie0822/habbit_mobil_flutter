import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/button_2.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:lottie/lottie.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: SingleChildScrollView(
          // Añadido SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.network(
                    "https://lottie.host/1982cc47-0163-4195-ad13-f2e02e0a251d/GQl2vmuCqF.json"),
                const SizedBox(height: 30),
                const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                      color: colorTextSecondaryLight,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'No te preocupes ingresa tu correo asociado a la aplicación para poder modificar tu contraseña.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                          10.0), // Ajusta este valor para cambiar el tamaño
                  child: MyTextField(
                    context: context,
                    hint: "Email",
                    isPassword: false,
                    icon: Icons.email_outlined,
                    key: const Key('email'),
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  onPressed: () {
                    context.push('/code');
                  },
                  text: "Enviar Código",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
