// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/data/controlers/forgot_password.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';
import 'package:lottie/lottie.dart';
// Vista de olvido de contraseña
class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}
// Estado de la vista de olvido de contraseña
class _ForgotViewState extends State<ForgotView> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordController _forgotPassword = ForgotPasswordController();
  // Método para liberar los recursos
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Maneja el envío del formulario
  void _handleSubmit() async {
    // Validar el formulario
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      // Validar el correo electrónico
      int id = await _forgotPassword.validateEmail(email);
      if (id > 0) {
        context.push('/code', extra: id); // Navega a la siguiente pantalla
      } else {
        showAlertDialog(
            'Error',
            'El correo ingresado no está registrado en la aplicación',
            1,
            context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usa MediaQuery para obtener el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    // Define diferentes paddings y tamaños de fuente para diferentes tamaños de pantalla
    final horizontalPadding = screenWidth < 600 ? 16.0 : 32.0;
    final textFontSize = screenWidth < 600 ? 16.0 : 20.0;
    final headingFontSize = screenWidth < 600 ? 28.0 : 32.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors
            .transparent, // Fondo transparente para la barra de la aplicación
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // Ícono de retroceso
          onPressed: () {
            context.pop(); // Navega hacia atrás en la pila de navegación
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  horizontalPadding), // Padding horizontal para el contenido
          child: Form(
            key: _formKey, // Asocia el formulario con la clave global
            child: Column(
              children: <Widget>[
                const SizedBox(width: 50),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.8,
                  child: Lottie.network(
                    "https://lottie.host/1982cc47-0163-4195-ad13-f2e02e0a251d/GQl2vmuCqF.json",
                  ), // Widget Lottie para mostrar una animación desde una URL
                ),
                const SizedBox(height: 30),
                Text(
                  // Texto
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: colorTextSecondaryLight,
                    fontSize: headingFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  //Texto
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
                    //Input de correo
                    context: context,
                    hint: "Email",
                    isPassword: false,
                    icon: Icons.email_outlined,
                    key: const Key('email'),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: CustomValidator.validateEmail,
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  // Boton
                  onPressed: _handleSubmit,
                  text: "Enviar código",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
