import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  //Tenemos el constructor
  const RegisterScreen({super.key});

  //Creacion del estado
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin{

  final _formKey = GlobalKey<FormState>();

  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOut),
    );
    _fadeInController.forward();
  }

    @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body:  SingleChildScrollView(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _fadeInAnimation, 
              builder: (context, child){
                return Opacity(
                  opacity: _fadeInAnimation.value,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                              "Registrar",
                              style: AppStyles.headline6(context, colorTexto),
                              ),
                              const SizedBox(height: 20),
                              //Inicio de los txt para el formulario
                              MyTextField(
                                context: context,
                                hint: "Nombre",
                                isPassword: false,
                                icon: Icons.drive_file_rename_outline,
                                key: const Key('nombre'),
                              ),
                              MyTextField(
                                context: context,
                                hint: "Apellido",
                                isPassword: false,
                                icon: Icons.drive_file_rename_outline,
                                key: const Key('apellido'),
                              ),
                               MyTextField(
                                context: context,
                                hint: "Correo electrónico",
                                isPassword: false,
                                icon: Icons.email_outlined,
                                key: const Key('email'),
                              ),
                              MyTextField(
                                context: context,
                                hint: "Telefóno",
                                isPassword: false,
                                icon: Icons.smartphone,
                                key: const Key('email'),
                              ),
                            ],
                          ),
                          )
                        ),

                  ),
                );
                

              }
              )
            
          ],

        ),
      )
    );
  }
}
