import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/widgets.dart';
import 'package:habbit_mobil_flutter/common/widgets/build_login.dart';
import 'package:habbit_mobil_flutter/data/controlers/login.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';

// Pantalla de inicio de sesión
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginState createState() => _LoginState();
}

// Estado de la pantalla de inicio de sesión
class _LoginState extends State<LoginScreen> with TickerProviderStateMixin {
  // Clave global para el formulario
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isLoading = false; // Nuevo booleano para manejar el estado de carga
  // Controlador de autenticación
  final AuthService _authService = AuthService();
  late AnimationController _fadeInController;
  late AnimationController _buttonController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _buttonScaleAnimation;
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Controlador para la animación de desvanecimiento
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOutCubic),
    );
    _fadeInController.forward();

    // Controlador para la animación de escala del botón
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

  // Liberar recursos
  @override
  void dispose() {
    _fadeInController.dispose();
    _buttonController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Maneja la animación de presión del botón
  void _onTapDown(TapDownDetails details) {
    _buttonController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _buttonController.reverse();
  }

  // Alterna la visibilidad de la contraseña
  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  // Maneja el inicio de sesión
  void _handleLogin() async {
    // Validar el formulario
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true; // Muestra el indicador de carga
      });

      final email = _emailController.text;
      final password = _passwordController.text;
      // Petición de inicio de sesión
      final success = await _authService.login(email, password);
      if (success) {
        context.go('/main', extra: 0);
      } else {
        showAlertDialog(
            'Error',
            'Asegúrese que a ingresando las credenciales correctamente.',
            1,
            context);
      }
      setState(() {
        isLoading = false; // Oculta el indicador de carga
      });
    }
  }

// Diseño de la pantalla de inicio de sesión
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

  // Construye el encabezado de la pantalla
  Widget _buildHeader(
      BuildContext context, double screenHeight, double screenWidth) {
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

  // Construye el formulario de inicio de sesión
  Widget _buildForm(BuildContext context, ThemeData theme, Color colorTexto,
      double screenWidth) {
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
                horizontal:
                    screenWidth * 0.1, // Padding para hacerlo más responsivo
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
                        controller: _emailController,
                        validator: CustomValidator.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _fadeInAnimation,
                    ),
                    LoginWidgets.buildAnimatedField(
                      context,
                      LoginWidgets.buildPasswordField(
                        context,
                        showPassword,
                        _togglePasswordVisibility,
                        _passwordController,
                      ),
                      _fadeInAnimation,
                    ),
                    const SizedBox(height: 10),
                    LoginWidgets.buildForgotPasswordButton(context, colorTexto),
                    const SizedBox(height: 20),
                    isLoading // Mostrar indicador de carga si está cargando
                        ? const Center(child: CircularProgressIndicator())
                        : LoginWidgets.buildLoginButton(
                            context,
                            _buttonScaleAnimation,
                            _onTapDown,
                            _onTapUp,
                            _handleLogin,
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
