import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'login_screen.dart'; // Importa el archivo login_screen.dart si es necesario
import 'package:habbit_mobil_flutter/utils/constants/colors.dart'; // Asegúrate de importar tus constantes de colores si las tienes

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3), // Start slightly below the center
      end: const Offset(0.0, 0.0), // End at the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.push('/login'); // Navega a la pantalla de login
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Logo.png',
                          width: 90,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Bienvenido',
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      nextScreen: const LoginScreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: primaryColor,
      splashIconSize: double.infinity,
      duration: 3000,
    );
  }
}
