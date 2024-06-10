import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  //Tenemos el constructor
  const RegisterScreen({super.key});

  //Creacion del estado
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOut),
    );
    _fadeInController.forward();
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                  animation: _fadeInAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeInAnimation.value,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 60),
                                  Text(
                                    "Registrar",
                                    style: AppStyles.headline6(
                                        context, colorTexto),
                                  ),
                                  const SizedBox(height: 10),
                                  //Inicio de los txt para el formulario
                                  MyTextField(
                                    context: context,
                                    hint: "Nombre",
                                    isPassword: false,
                                    icon: Icons.drive_file_rename_outline,
                                    key: const Key('nombre'),
                                  ),
                                  const SizedBox(height: 10),
                                  MyTextField(
                                    context: context,
                                    hint: "Apellido",
                                    isPassword: false,
                                    icon: Icons.drive_file_rename_outline,
                                    key: const Key('apellido'),
                                  ),
                                  const SizedBox(height: 10),
                                  MyTextField(
                                    context: context,
                                    hint: "Email",
                                    isPassword: false,
                                    icon: Icons.email_outlined,
                                    key: const Key('email'),
                                  ),
                                  const SizedBox(height: 10),
                                  MyTextField(
                                    context: context,
                                    hint: "Telefóno",
                                    isPassword: false,
                                    icon: Icons.smartphone,
                                    key: const Key('telefono'),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(8),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Stack(
                                    children: [
                                      MyTextField(
                                        context: context,
                                        hint: "Contraseña",
                                        isPassword: !showPassword,
                                        icon: Icons.lock_outline,
                                        key: const Key('contraseña'),
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
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomButton(
                                      onPressed: () {
                                        context.push('/main');
                                      },
                                      text: "Crear cuenta",
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text.rich(
                                      TextSpan(
                                        text: "¿Ya tienes una cuenta? ",
                                        style: TextStyle(
                                          color: theme
                                              .textTheme.bodyText2?.color
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
                                                // Navigate to registration
                                              },
                                          ),
                                        ],
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                    );
                  }
              )
            ],
          ),
        )
    );
  }
}
