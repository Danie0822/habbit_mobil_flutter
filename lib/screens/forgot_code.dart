import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/data/controlers/send_mail.dart';
import 'package:habbit_mobil_flutter/data/models/confirm_password.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
// Vista de código de verificación
class CodeView extends StatefulWidget {
  final int idUsuario;
  const CodeView({super.key, required this.idUsuario});

  @override
  _CodeViewState createState() => _CodeViewState();
}
// Estado de la vista de código
class _CodeViewState extends State<CodeView> {
  final RecoveryController _recoveryController = RecoveryController();
  int _idUsuario = 0;
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _idUsuario = widget.idUsuario;
    _sendEmail();
  }

  // Método para enviar el correo electrónico
  void _sendEmail() async {
    final result = await _recoveryController.sendEmail(_idUsuario);
    if (result == 1) {
      showAlertDialog('Correo enviado',
          'Se ha enviado un correo con el código de verificación', 3, context);
    } else {
      showAlertDialog('Error', 'No se pudo enviar el correo', 2, context);
    }
  }

  // Método para verificar el código
  void _sendVerificar() async {
    final codigo = _controllers.map((controller) => controller.text).join();
    if (codigo.length == 5) {
      final arguments =
          ConfirmViewArguments(idUsuario: _idUsuario, codigo: codigo);
      final result = await _recoveryController.sendRequest(
          _idUsuario, codigo, '', 'validar');
      if (result == 1) {
        context.push('/pass', extra: arguments);
      } else {
        showAlertDialog('Error', 'El código ingresado es incorrecto. Por favor, verifica el código e inténtalo nuevamente.', 1, context);
      }
    } else {
      showAlertDialog(
          'Advertencia', 'Por favor, complete todos los campos', 1, context);
    }
  }

  // Diseño de la pantalla
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < 600 ? 16.0 : 32.0;
    final textFontSize = screenWidth < 600 ? 16.0 : 20.0;
    final headingFontSize = screenWidth < 600 ? 30.0 : 36.0;
    final inputFieldSize = screenWidth < 600 ? 60.0 : 80.0;

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
        child: Column(
          children: [
            SizedBox(
              width: screenWidth * 0.6,
              height: screenWidth * 0.6,
              child: Lottie.network(
                "https://lottie.host/94694577-8cf3-4fd1-96a0-aca85b318bc9/lL7IY9NZCI.json",
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Verifica tu correo ',
              style: TextStyle(
                color: colorTextSecondaryLight,
                fontSize: headingFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Por favor, introduzca el código de 4 dígitos enviado a pixeltoonss@gmail.com',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: textFontSize,
              ),
            ),
            const SizedBox(height: 32),
            CodeInputFields(
                controllers: _controllers, inputFieldSize: inputFieldSize),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                _sendEmail();
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
              onPressed: _sendVerificar,
              text: "Verificar",
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para los campos de entrada de código
class CodeInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final double inputFieldSize;

  const CodeInputFields(
      {super.key, required this.controllers, required this.inputFieldSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          5,
          (index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: CodeInputField(
                    controller: controllers[index], size: inputFieldSize),
              )),
    );
  }
}

// Widget para el campo de entrada de código
class CodeInputField extends StatelessWidget {
  final TextEditingController controller;
  final double size;

  const CodeInputField(
      {super.key, required this.controller, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size * 0.4,
          letterSpacing: 2.0,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          filled: true,
          counterText: '',
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
