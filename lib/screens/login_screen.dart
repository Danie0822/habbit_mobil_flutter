import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/widgets.dart';
import 'package:habbit_mobil_flutter/screens/build_login.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  late AnimationController _fadeInController;
  late AnimationController _buttonController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOutCubic),
    );
    _fadeInController.forward();

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _buttonController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _buttonController.reverse();
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    Color colorTexto = ThemeUtils.getColorBasedOnBrightness(
        context, secondaryColor, lightTextColor);

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context, screenHeight, screenWidth),
              _buildForm(context, theme, colorTexto, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenHeight, double screenWidth) {
    final theme = Theme.of(context);
    return Container(
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
          width: screenWidth * 0.5,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, ThemeData theme, Color colorTexto, double screenWidth) {
    return AnimatedBuilder(
      animation: _fadeInAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeInAnimation.value,
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
                horizontal: screenWidth * 0.1, // Ajuste de padding para hacerlo más responsivo
                vertical: 20,
              ),
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
                    LoginWidgets.buildAnimatedField(
                      context,
                      MyTextField(
                        context: context,
                        hint: "Email",
                        isPassword: false,
                        icon: Icons.email_outlined,
                        key: const Key('email'),
                      ),
                      _fadeInAnimation,
                    ),
                    LoginWidgets.buildAnimatedField(
                      context,
                      LoginWidgets.buildPasswordField(
                        context,
                        showPassword,
                        _togglePasswordVisibility,
                      ),
                      _fadeInAnimation,
                    ),
                    const SizedBox(height: 10),
                    LoginWidgets.buildForgotPasswordButton(context, colorTexto),
                    const SizedBox(height: 20),
                    LoginWidgets.buildLoginButton(
                      context,
                      _buttonScaleAnimation,
                      _onTapDown,
                      _onTapUp,
                    ),
                    const SizedBox(height: 20),
                    LoginWidgets.buildSignUpPrompt(context, colorTexto),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
