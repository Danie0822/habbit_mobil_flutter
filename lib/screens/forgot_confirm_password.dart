import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/data/controlers/send_mail.dart';
import 'package:habbit_mobil_flutter/data/models/confirm_password.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/constants/crypto.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';
import 'package:lottie/lottie.dart';

// Vista de confirmación de contraseña
class ConfirmView extends StatefulWidget {
  final ConfirmViewArguments arguments;
  const ConfirmView({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ConfirmView> createState() => _ConfirmViewState();
}

// Argumentos de la vista de confirmación
class _ConfirmViewState extends State<ConfirmView> {
  final RecoveryController _recoveryController = RecoveryController();
  late ConfirmViewArguments arguments;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // Inicializar los argumentos
  @override
  void initState() {
    super.initState();
    arguments = widget.arguments;
  }

  // Método para cambiar la contraseña
  void _forgotPassword() async {
    // Validar los campos
    if (_formKey.currentState?.validate() ?? false) {
      // Obtener la clave y confirmarla
      final clave = _passwordController.text;
      final confirm = _confirmController.text;
      final hashedPassword = hashPassword(clave);
      if (clave == confirm) {
        // Enviar la solicitud de cambio de contraseña
        final result = await _recoveryController.sendRequest(
            arguments.idUsuario, arguments.codigo, hashedPassword, 'clave');
        // Mostrar el resultado
        if (result == 1) {
          showAlertDialogScreen(
            'Éxito',
            'Contraseña cambiada correctamente',
            3,
            context,
            () {
              context.go("/login");
            },
          );
        } else {
          showAlertDialog(
              'Advertencia', 'No se pudo cambiar la contraseña', 1, context);
        }
      } else {
        showAlertDialog(
            'Advertencia', 'Las contraseñas no coinciden', 1, context);
      }
    }
  }

  // Diseño de la pantalla
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < 600 ? 16.0 : 32.0;
    final textFontSize = screenWidth < 600 ? 16.0 : 20.0;
    final headingFontSize = screenWidth < 600 ? 25.0 : 30.0;
    // Tamaño de los campos de entrada
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
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                width: screenWidth * 0.6,
                height: screenWidth * 0.6,
                child: Lottie.network(
                  "https://lottie.host/e9aa8268-3e70-4865-a5d0-79a44f310d0d/WIp8LUl9TY.json", // Animación de contraseña
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Ingrese su nueva contraseña', // Título
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: colorTextSecondaryLight,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Para restablecer su acceso, por favor ingrese su nueva contraseña en los campos a continuación.', // Descripción
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textFontSize,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20.0),
              // Campos de contraseña
              MyTextField(
                context: context,
                hint: "Contraseña nueva",
                isPassword: true,
                icon: Icons.lock,
                controller: _passwordController,
                validator: CustomValidator.validatePassword,
                key: const Key('password'),
              ),
              const SizedBox(height: 20.0),
              // Campos de confirmación de contraseña
              MyTextField(
                context: context,
                hint: "Confirma la contraseña",
                isPassword: true,
                icon: Icons.lock,
                controller: _confirmController,
                validator: CustomValidator.validatePassword,
                key: const Key('confirm'),
              ),
              const SizedBox(height: 20.0),
              CustomButton(
                onPressed: _forgotPassword,
                text: "Restablecer",
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
