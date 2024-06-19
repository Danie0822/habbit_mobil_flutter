import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperación de Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ingrese su nueva contraseña',
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            MyTextField(
                    context: context,
                    hint: "a",
                    isPassword: false,
                    icon: Icons.email_outlined,
                    key: const Key('email'),
                  ),
            const SizedBox(height: 20.0),
          
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para cambiar la contraseña
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConfirmView(),
  ));
}
