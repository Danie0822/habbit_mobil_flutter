import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:lottie/lottie.dart'; 
import 'package:habbit_mobil_flutter/common/widgets/button.dart'; 

class PasswordDone extends StatelessWidget {
  const PasswordDone({super.key}); 

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Usa MediaQuery para obtener el tamaño de la pantalla actual.
    final isSmallScreen = screenWidth < 600; 
    final verticalPadding = isSmallScreen ? 16.0 : 32.0; 
    final textFontSize = isSmallScreen ? 16.0 : 20.0; 
    final headingFontSize = isSmallScreen ? 25.0 : 30.0; 

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(verticalPadding), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text(
                'Restablecimiento exitoso', // Título principal.
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: headingFontSize, 
                  fontWeight: FontWeight.bold, 
                  color: colorTextSecondaryLight, 
                ),
              ),
              const SizedBox(height: 16), 
              Text(
                'Tu contraseña ha sido restablecida con éxito. Ahora puedes usar tu nueva contraseña para iniciar sesión.', // Descripción.
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: textFontSize, 
                  color: Colors.grey, 
                ),
              ),
              const SizedBox(height: 32), 
              SizedBox(
                width: screenWidth * 0.8,
                height: screenWidth * 0.8,
                child: Lottie.network(
                  "https://lottie.host/db1ab1ca-5c14-440f-85e1-6c0f352586d7/ceNVRPZRYQ.json",
                ), // Widget Lottie para mostrar una animación desde una URL.
              ),
              const SizedBox(height: 40), 
              CustomButton( //Botón.
                onPressed: () {
                  context.push('/login'); // Navega a la ruta '/login' al hacer clic en el botón.
                },
                text: "Regresar",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
