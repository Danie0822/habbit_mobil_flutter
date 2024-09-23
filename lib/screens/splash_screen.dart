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
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkFirstLaunch();
      }
    });
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    bool isLogged = await StorageService.isRegistered();
    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      context.go('/onboard');
    } else {
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
                  width: screenWidth * 0.25, // Ajustar el ancho de la imagen al 25% del ancho de la pantalla
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: screenWidth * 0.1, // Ajustar el tamaño de la fuente al 10% del ancho de la pantalla
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
