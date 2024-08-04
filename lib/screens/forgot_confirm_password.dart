import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Colors,
        Column,
        EdgeInsets,
        FontWeight,
        Form,
        FormState,
        GlobalKey,
        Icon,
        IconButton,
        Icons,
        Key,
        MediaQuery,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextAlign,
        TextEditingController,
        TextStyle,
        Widget;
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

class ConfirmView extends StatefulWidget {
  final ConfirmViewArguments arguments;
  ConfirmView({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ConfirmView> createState() => _ConfirmViewState();
}

class _ConfirmViewState extends State<ConfirmView> {
  final RecoveryController _recoveryController = RecoveryController();
  late ConfirmViewArguments arguments;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    arguments = widget.arguments;
  }

  void _forgotPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final clave = _passwordController.text;
      final confirm = _confirmController.text;
      final hashedPassword = hashPassword(clave);
      if (clave == confirm) {
        final result = await _recoveryController.sendRequest(
            arguments.idUsuario, arguments.codigo, hashedPassword, 'clave');
        if (result == 1) {
          showAlertDialog(
              'Éxito', 'Contraseña cambiada correctamente', context);
          context.push('/login');
        } else {
          showAlertDialog('Error', 'No se pudo cambiar la contraseña', context);
        }
      } else {
        showAlertDialog('Error', 'Las contraseñas no coinciden', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth < 600 ? 16.0 : 32.0;
    final textFontSize = screenWidth < 600 ? 16.0 : 20.0;
    final headingFontSize = screenWidth < 600 ? 25.0 : 30.0;

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
                  "https://lottie.host/e9aa8268-3e70-4865-a5d0-79a44f310d0d/WIp8LUl9TY.json",
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Ingrese su nueva contraseña',
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                  color: colorTextSecondaryLight,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Para restablecer su acceso, por favor ingrese su nueva contraseña en los campos a continuación.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textFontSize,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20.0),
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
