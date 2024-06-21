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
    // Use MediaQuery to get the screen size
    final screenWidth = MediaQuery.of(context).size.width;

    // Define different paddings for different screen sizes
    final horizontalPadding = screenWidth < 600 ? 16.0 : 32.0;
    final textFontSize = screenWidth < 600 ? 16.0 : 20.0;
    final headingFontSize = screenWidth < 600 ? 28.0 : 32.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: <Widget>[
              const SizedBox(width: 50),
              SizedBox(
                width: screenWidth * 0.8,
                height: screenWidth * 0.8,
                child: Lottie.network(
                  "https://lottie.host/1982cc47-0163-4195-ad13-f2e02e0a251d/GQl2vmuCqF.json",
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: colorTextSecondaryLight,
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'No te preocupes ingresa tu correo asociado a la aplicación para poder modificar tu contraseña.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textFontSize,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                text: "Enviar código",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
