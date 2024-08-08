//Importacion de paquetes a utilizar
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/data/controlers/register.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';

//Creaciónn y construcción de stateful widget llamado register screen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  final AuthService _authService = AuthService();

  late AnimationController _textController;
  late Animation<Offset> _textAnimation;
  late AnimationController _inputsController;
  late Animation<Offset> _inputsAnimation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Creacion de animacion para el texto de la pantalla
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _textAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    //Creacion de la animacion de los inputs
    _inputsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _inputsAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _inputsController, curve: Curves.easeInOut),
    );

    _textController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _inputsController.forward();
      });
    });
  }

  // Maneja el inicio de sesión
  void _handleRegister() async {
    // Validar el formulario
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final password = _passwordController.text;
      // Petición de inicio de sesión
      final success = await _authService.register(name, email, phone, password);
      if (success) {
        context.go('/thanks_register');
      } else {
        showAlertDialog('Error', 'Este correo ya ha sido registrado en el programa por favor intente con otro', 1, context);
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _inputsController.dispose();
    super.dispose();
  }

// Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
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
        child: Column(
          children: [
            SlideTransition(
              position: _textAnimation,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Widget del texto mostrado en pantalla
                      Text(
                        "Registrar",
                        style: AppStyles.headline5(context, colorTexto),
                      ),
                      SizedBox(height: height * 0.01),
                      //Widget del texto mostrado en pantalla
                      Text(
                        "¡Regístrate y entérate de las ventajas de Habit mobile!",
                        style: AppStyles.subtitle1(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: _inputsAnimation,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.02,
                    horizontal: width * 0.05,
                  ),
                  //Inicio del formulario para enviar informacion
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        //Widget del input de nombre
                        MyTextField(
                          context: context,
                          hint: "Nombre",
                          isPassword: false,
                          icon: Icons.drive_file_rename_outline,
                          key: const Key('nombre'),
                          validator: CustomValidator.validateName,
                          controller: _nameController,
                        ),
                        SizedBox(height: height * 0.02),
                        //Widget del input para email
                        MyTextField(
                          context: context,
                          hint: "Email",
                          isPassword: false,
                          icon: Icons.email_outlined,
                          key: const Key('email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: CustomValidator.validateEmail,
                          controller: _emailController,
                        ),
                        SizedBox(height: height * 0.02),
                        //Widget del input para el telefono
                        MyTextField(
                          context: context,
                          hint: "Teléfono",
                          isPassword: false,
                          icon: Icons.smartphone,
                          key: const Key('telefono'),
                          keyboardType: TextInputType.emailAddress,
                          validator: CustomValidator.validatePhoneNumber,
                          controller: _phoneController,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(9),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Stack(
                          children: [ 
                            //Widget del input para la contraseña
                            MyTextField(
                              context: context,
                              hint: "Contraseña",
                              isPassword: !showPassword,
                              icon: Icons.lock_outline,
                              key: const Key('contraseña'),
                              validator: CustomValidator.validatePassword,
                              controller: _passwordController,
                            ),
                            Positioned(
                              right: 0,
                              top: 14,
                              child: IconButton(
                                icon: Icon(showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Align(
                          alignment: Alignment.center,
                          //Widget del boton que redirige a las otras pantallas
                          child: CustomButton(
                            onPressed: () {
                              _handleRegister();
                            },
                            text: "Crear cuenta",
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Align(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                              text: "¿Ya tienes una cuenta? ",
                              style: TextStyle(
                                color: theme.textTheme.bodyMedium?.color
                                    ?.withOpacity(0.6),
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: "Inicia sesión",
                                  style: TextStyle(
                                    color: colorTexto,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push('/login');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
