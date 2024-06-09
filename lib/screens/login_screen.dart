import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.35,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logoLight.png',
                  height: screenHeight * 0.25,
                ),
              ),
            ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "Bienvenido de vuelta",
                              style: AppStyles.headline6(context, colorTexto),
                            ),
                            Text(
                              "Inicia sesión para continuar",
                              style: AppStyles.subtitle1(context),
                            ),
                            const SizedBox(height: 20),
                            MyTextField(
                              context: context,
                              hint: "Email",
                              isPassword: false,
                              icon: Icons.email_outlined,
                              key: const Key('email'),
                            ),
                            Stack(
                              children: [
                                MyTextField(
                                  context: context,
                                  hint: "Password",
                                  isPassword: !showPassword,
                                  icon: Icons.lock_outline,
                                  key: const Key('password'),
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
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Olvidaste tu contraseña?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: colorTexto,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: CustomButton(
                                onPressed: () {
                                  context.push('/main');
                                },
                                text: "Inicia sesión",
                              ),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.center,
                              child: Text.rich(
                                TextSpan(
                                  text: "No tienes cuenta? ",
                                  style: TextStyle(
                                    color: theme.textTheme.bodyText2?.color
                                        ?.withOpacity(0.6),
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Crea una nueva",
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
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
