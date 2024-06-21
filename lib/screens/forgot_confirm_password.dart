import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Importa el paquete GoRouter para manejar la navegación.
import 'package:habbit_mobil_flutter/common/widgets/button_2.dart'; 
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart'; 
import 'package:habbit_mobil_flutter/utils/constants/colors.dart'; 
import 'package:lottie/lottie.dart'; // Importa el paquete Lottie para mostrar animaciones.

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa MediaQuery para obtener el tamaño de la pantalla actual.
    final screenWidth = MediaQuery.of(context).size.width;

    // Define diferentes paddings y tamaños de fuente para diferentes tamaños de pantalla.
    final horizontalPadding = screenWidth < 600 ? 16.0 : 32.0; 
    final textFontSize = screenWidth < 600 ? 16.0 : 20.0; 
    final headingFontSize = screenWidth < 600 ? 25.0 : 30.0; 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // Icono de retroceso en la barra de la aplicación.
          onPressed: () {
            context.pop(); // Navega hacia atrás en la pila de navegación.
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding), 
        child: Column(
          children: [
            SizedBox(
              width: screenWidth * 0.6,
              height: screenWidth * 0.6,
              child: Lottie.network(
                "https://lottie.host/e9aa8268-3e70-4865-a5d0-79a44f310d0d/WIp8LUl9TY.json",
              ), // Widget Lottie para mostrar una animación desde una URL.
            ),
            const SizedBox(height: 20.0), 
            Text(
              'Ingrese su nueva contraseña', // Título principal.
              style: TextStyle(
                fontSize: headingFontSize, 
                fontWeight: FontWeight.bold, 
                color: colorTextSecondaryLight,
              ),
            ),
            const SizedBox(height: 20.0), 
            Text(
              'Para restablecer su acceso, por favor ingrese su nueva contraseña en los campos a continuación.', // Descripción.
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textFontSize, 
                color: Colors.grey, 
              ),
            ),
            const SizedBox(height: 20.0), 
            MyTextField(// Input de texto.
              context: context,
              hint: "Contraseña nueva", // Placeholder del campo de texto.
              isPassword: true, 
              icon: Icons.lock, 
              key: const Key('password'), // Key única para identificar este campo.
            ),
            const SizedBox(height: 20.0), 
            MyTextField(// Input de texto.
              context: context,
              hint: "Confirma la contraseña", // Placeholder del campo de texto.
              isPassword: true,
              icon: Icons.lock, 
              key: const Key('confirm'), // Key única para identificar este campo.
            ),
            const SizedBox(height: 20.0),
            CustomButton(//Botón.
              onPressed: () {
                context.push('/done'); // Navega a la ruta '/done' al hacer clic en el botón.
              },
              text: "Restablecer", 
            ),
            const SizedBox(height: 20.0), 
          ],
        ),
      ),
    );
  }
}
