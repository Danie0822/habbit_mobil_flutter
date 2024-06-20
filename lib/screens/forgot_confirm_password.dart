import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/button_2.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:lottie/lottie.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
           context.pop();
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Lottie.network(
                          "https://lottie.host/e9aa8268-3e70-4865-a5d0-79a44f310d0d/WIp8LUl9TY.json",
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Ingrese su nueva contraseña',
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: colorTextSecondaryLight),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Para restablecer su acceso, por favor ingrese su nueva contraseña en los campos a continuación. ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                      const SizedBox(height: 20.0),
                      MyTextField(
                        context: context,
                        hint: "Contraseña nueva",
                        isPassword: true,
                        icon: Icons.lock,
                        key: const Key('password'),
                      ),
                      const SizedBox(height: 20.0),
                      MyTextField(
                        context: context,
                        hint: "Confirma la contraseña",
                        isPassword: true,
                        icon: Icons.lock,
                        key: const Key('confirm'),
                      ),
                      const SizedBox(height: 20.0),
                      CustomButton(
                        onPressed: () {
                          context.push('/done');
                        },
                        text: "Restablecer",
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
