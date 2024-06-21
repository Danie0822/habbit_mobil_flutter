import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Importa el paquete GoRouter para manejar la navegación.
import 'package:habbit_mobil_flutter/common/widgets/button_2.dart'; 
import 'package:habbit_mobil_flutter/utils/constants/colors.dart'; 
import 'package:lottie/lottie.dart'; // Importa el paquete Lottie para mostrar animaciones.

class CodeView extends StatelessWidget {
  const CodeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa MediaQuery para obtener el tamaño de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    // Define diferentes paddings y tamaños de fuente para diferentes tamaños de pantalla
    final horizontalPadding = screenWidth < 600 ? 16.0 : 32.0; 
    final textFontSize = screenWidth < 600 ? 16.0 : 20.0; 
    final headingFontSize = screenWidth < 600 ? 30.0 : 36.0; 
    final inputFieldSize = screenWidth < 600 ? 60.0 : 80.0; 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), // Ícono de retroceso
          onPressed: () {
            context.pop(); // Navega hacia atrás en la pila de navegación
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
                "https://lottie.host/94694577-8cf3-4fd1-96a0-aca85b318bc9/lL7IY9NZCI.json",
              ), // Widget Lottie para mostrar una animación desde una URL
            ),
            const SizedBox(height: 24), 
            Text(
              'Verifica tu correo', // Título principal
              style: TextStyle(
                color: colorTextSecondaryLight, 
                fontSize: headingFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Por favor, introduzca el código de 4 dígitos enviado a pixeltoonss@gmail.com', // Descripción
              textAlign: TextAlign.center, 
              style: TextStyle(
                color: Colors.grey, 
                fontSize: textFontSize, 
              ),
            ),
            const SizedBox(height: 32), 
            CodeInputFields(inputFieldSize: inputFieldSize), 
            const SizedBox(height: 24), 
            GestureDetector(// Input de texto
              onTap: () {
                
              },
              child: const Text(
                'Reenviar código', 
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16, 
                ),
              ),
            ),
            const SizedBox(height: 24), 
            CustomButton(// Boton
              onPressed: () {
                context.push('/pass'); // Navega a la ruta '/pass' al hacer clic en el botón
              },
              text: "Verificar", 
            ),
          ],
        ),
      ),
    );
  }
}

class CodeInputFields extends StatelessWidget {
  final double inputFieldSize;

  const CodeInputFields({super.key, required this.inputFieldSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          List.generate(4, (index) => CodeInputField(size: inputFieldSize)), // Genera 4 campos de entrada de código
    );
  }
}

class CodeInputField extends StatelessWidget {
  final double size;

  const CodeInputField({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), 
      ),
      child: TextField(
        textAlign: TextAlign.center, 
        style: TextStyle(
          fontSize: size * 0.4,
          letterSpacing: 2.0, 
          fontWeight: FontWeight.bold, 
        ),
        keyboardType: TextInputType.number, 
        maxLength: 1, 
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), 
          ),
          filled: true, 
          counterText: '', 
          contentPadding: EdgeInsets.all(0), 
        ),
      ),
    );
  }
}
