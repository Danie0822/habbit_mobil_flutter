// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Controlador de animación
  late AnimationController _controller;
  // Animación de opacidad
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // Crear controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    // Crear animación de opacidad
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // Agregar un listener para la animación
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkFirstLaunch();
      }
    });
  }

  // Método para comprobar si es el primer lanzamiento
  Future<void> _checkFirstLaunch() async {
    // Obtener las preferencias compartidas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Comprobar si es el primer lanzamiento
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    // Comprobar si el usuario está registrado
    bool isLogged = await StorageService.isRegistered();
    // Si es el primer lanzamiento, ir a la pantalla de bienvenida
    if (isFirstLaunch) {
      // Establecer isFirstLaunch en falso
      await prefs.setBool('isFirstLaunch', false);
      context.go('/onboard');
    } else {
      // Si el usuario está registrado, ir a la pantalla principal
      if (isLogged) {
        context.go("/main", extra: 0);
      } else {
        context.go('/login');
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
    // Obtener el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    width: screenWidth *
                        0.25, // Ajustar el ancho de la imagen al 25% del ancho de la pantalla
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: screenWidth *
                          0.1, // Ajustar el tamaño de la fuente al 10% del ancho de la pantalla
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
    );
  }
}
