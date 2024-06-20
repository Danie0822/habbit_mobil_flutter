import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  late AnimationController _textController;
  late Animation<Offset> _textAnimation;
  late AnimationController _inputsController;
  late Animation<Offset> _inputsAnimation;

  @override
  void initState() {
    super.initState();
    
    // Animation for the text
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

  @override
  void dispose() {
    _textController.dispose();
    _inputsController.dispose();
    super.dispose();
  }

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
                    vertical: height * 0.02,
                    horizontal: width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.08),
                      Text(
                        "Registrar",
                        style: AppStyles.headline5(context, colorTexto),
                      ),
                      SizedBox(height: height * 0.01),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        MyTextField(
                          context: context,
                          hint: "Nombre",
                          isPassword: false,
                          icon: Icons.drive_file_rename_outline,
                          key: const Key('nombre'),
                        ),
                        SizedBox(height: height * 0.02),
                        MyTextField(
                          context: context,
                          hint: "Email",
                          isPassword: false,
                          icon: Icons.email_outlined,
                          key: const Key('email'),
                        ),
                        SizedBox(height: height * 0.02),
                        MyTextField(
                          context: context,
                          hint: "Teléfono",
                          isPassword: false,
                          icon: Icons.smartphone,
                          key: const Key('telefono'),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
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
                        SizedBox(height: height * 0.02),
                        Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                            onPressed: () {
                              context.push('/ubi');
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
