//Importacion de paquetes a utilizar
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/data/controlers/update_client.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';

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
  final AuthService _updateInfoController = AuthService();
  bool showPassword = false;

  String id = "";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadClientId();
  }

  Future<void> _loadClientId() async {
    final String idCliente = await StorageService.getClientId() ?? '';
    setState(() {
      id = idCliente;
    });
    _loadClientInfo(idCliente);
  }
  // Método para cargar la información
Future<void> _loadClientInfo(String id) async {
  try {
    final clientInfo = await _updateInfoController.infoClient(id);
    if (clientInfo.clients != null && clientInfo.clients!.isNotEmpty) {
      final client = clientInfo.clients!.first;
      setState(() {
        _nameController.text = client.name ?? '';
        _emailController.text = client.email ?? '';
        _phoneController.text = client.phone ?? '';
      });
    } else {
      showAlertDialog('Error', 'No se pudo cargar la información del cliente', 2, context);
    }
  } catch (error) {
    showAlertDialog('Error', 'Error al cargar datos del cliente: $error', 2, context);
  }
}



  // Método para actualizar la información
void _updateInfo() async {
  if (_formKey.currentState?.validate() ?? false) {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final result = await _updateInfoController.updateClient(id, name, email, phone);
    if (result) {
      showAlertDialogScreen('Éxito', 'Su información se ha actualizado correctamente', 3, context, () {
        context.push("/main", extra: 3);
      });
    } else {
      showAlertDialog('Error', 'Este correo ya ha sido registrado en el programa por favor intente con otro', 2, context);
    }
  }
}


  // Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light ? secondaryColor : lightTextColor;

    // Inicio de la construcción de la pantalla
    return Scaffold(
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
                    // Widget que muestra el texto
                    Text(
                      "Cambiar perfil",
                      style: AppStyles.headline5(context, colorTexto),
                    ),
                    const SizedBox(height: 10),
                    // Widget que muestra el texto
                    Text(
                      "Actualizate la información de tu perfil",
                      style: AppStyles.subtitle1(context),
                    ),
                    const SizedBox(height: 40),
                    // Inicio de los txt para el formulario
                    MyTextField(
                      context: context,
                      hint: "Nombre",
                      isPassword: false,
                      icon: Icons.drive_file_rename_outline,
                      key: const Key('nombre'),
                      validator: CustomValidator.validateName,
                      controller: _nameController,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      context: context,
                      hint: "Email",
                      isPassword: false,
                      icon: Icons.email_outlined,
                      key: const Key('email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: CustomValidator.validateEmail,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      context: context,
                      hint: "Teléfono",
                      isPassword: false,
                      icon: Icons.smartphone,
                      key: const Key('telefono'),
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      validator: CustomValidator.validatePhoneNumber,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(9),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      // Widget del botón para seguir a la siguiente pantalla
                      child: CustomButton(
                        onPressed: _updateInfo,
                        text: "Actualizar información",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
