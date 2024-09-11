import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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
      begin: const Offset(0.0, 0.3),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Una vez que la animación se complete, verifica si es la primera vez que se lanza la aplicación
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkFirstLaunch();
      }
    });
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch =
        prefs.getBool('isFirstLaunch') ?? true; // Por defecto es true
    bool isLogged = await StorageService.isRegistered(); // Por defecto es false
    if (isFirstLaunch) {
      // Si es la primera vez, guardamos el valor como false para futuras ejecuciones
      await prefs.setBool('isFirstLaunch', false);
      context.go('/onboard'); // Navega a la pantalla de Onboarding
    } else {
      if (isLogged) {
        context.go("/main", extra: 0); // Navega a la pantalla principal
      } else {
        context.go('/login'); // Navega a la pantalla de Login
      }
    }
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
      nextScreen: const SizedBox
          .shrink(), // No se necesita nextScreen, la redirección se maneja manualmente
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: primaryColor,
      splashIconSize: double.infinity,
      duration: 3000,
    );
  }
}
