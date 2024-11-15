// Librería de widgets para la pantalla de inicio de sesión
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';

class LoginWidgets {
  // Construye el campo de contraseña con opción para mostrar/ocultar la contraseña
  static Widget buildPasswordField(
      BuildContext context, bool showPassword, Function togglePasswordVisibility, TextEditingController controllerCallback) {
    return Stack(
      children: [
        MyTextField(
          context: context,
          hint: "Password",
          isPassword: !showPassword,
          icon: Icons.lock_outline,
          controller: controllerCallback,
          key: const Key('password'),
          validator: CustomValidator.validatePassword,
        ),
        Positioned(
          right: 0,
          top: 14,
          child: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
                key: ValueKey<bool>(showPassword),
              ),
            ),
            onPressed: () {
              togglePasswordVisibility();
            },
          ),
        ),
      ],
    );
  }

  // Construye el botón "¿Olvidaste tu contraseña?"
  static Widget buildForgotPasswordButton(
      BuildContext context, Color colorTexto) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          context.push('/forgot');
        },
        child: Text(
          "Olvidaste tu contraseña?",
          style: TextStyle(
            fontSize: 16,
            color: colorTexto,
          ),
        ),
      ),
    );
  }

  // Construye el botón de inicio de sesión animado
  static Widget buildLoginButton(BuildContext context,
      Animation<double> buttonScaleAnimation, Function onTapDown, Function onTapUp, VoidCallback onTap) {
    return Align(
      alignment: Alignment.center,
      child: ScaleTransition(
        scale: buttonScaleAnimation,
        child: CustomButton(
          onPressed: onTap,
          text: "Inicia sesión",
        ),
      ),
    );
  }

  // Construye el mensaje para registrarse con enlace para crear una nueva cuenta
  static Widget buildSignUpPrompt(BuildContext context, Color colorTexto) {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          text: "No tienes cuenta? ",
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
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
                  context.push('/registar');
                },
            ),
          ],
        ),
      ),
    );
  }

  // Construye un campo animado con una animación de desvanecimiento
  static Widget buildAnimatedField(
      BuildContext context, Widget child, Animation<double> fadeInAnimation) {
    return AnimatedBuilder(
      animation: fadeInAnimation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.translationValues(
            0.0,
            50 * (1 - fadeInAnimation.value),
            0.0,
          )..scale(fadeInAnimation.value, fadeInAnimation.value),
          child: Opacity(
            opacity: fadeInAnimation.value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
