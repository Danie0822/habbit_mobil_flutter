//Importacion de paquetes a utilizar
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

//Creación y construcción de stateful widget llamado change profile screen
class ChangeProfile extends StatefulWidget {
  //Tenemos el constructor
  const ChangeProfile({super.key});

  //Creacion del estado
  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
  }

// Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    Theme.of(context);
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

//Incio de la construccion de la pantalla
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    //Widget que muestra el texto
                    Text(
                      "Cambiar perfil",
                      style: AppStyles.headline5(context, colorTexto),
                    ),
                    const SizedBox(height: 10),
                    //Widget que muestra el texto
                    Text(
                      "Actualizate la información de tu perfil",
                      style: AppStyles.subtitle1(context),
                    ),
                    const SizedBox(height: 40),
                    //Inicio de los txt para el formulario
                    MyTextField(
                      context: context,
                      hint: "Nombre",
                      isPassword: false,
                      icon: Icons.drive_file_rename_outline,
                      key: const Key('nombre'),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      context: context,
                      hint: "Email",
                      isPassword: false,
                      icon: Icons.email_outlined,
                      key: const Key('email'),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      context: context,
                      hint: "Telefóno",
                      isPassword: false,
                      icon: Icons.smartphone,
                      key: const Key('telefono'),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                      ],
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      //Widget del boton para seguir a la siguiente pantalla
                      child: CustomButton(
                        onPressed: () {
                          context.push('/ubi');
                        },
                        text: "Actualizar información",
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    ));
  }
}
