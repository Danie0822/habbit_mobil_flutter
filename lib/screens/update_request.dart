// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_area.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/data/controlers/request_controlers.dart';
import 'package:habbit_mobil_flutter/data/models/request_model.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';
import 'package:go_router/go_router.dart';

// Pantalla para actualizar una solicitud
class UpdateRequest extends StatefulWidget {
  const UpdateRequest({super.key, required this.request});
  final RequestModel request;
  
  @override
  State<UpdateRequest> createState() => _UpdateRequestState();
}

class _UpdateRequestState extends State<UpdateRequest> {
  final _formKey = GlobalKey<FormState>();
  // Controladores para los campos de texto
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _gananciaController = TextEditingController();
  final RequestService _updateController = RequestService();
  int? idSolicitud;

  // Método para cargar categorías y zonas
  @override
  void initState() {
    super.initState();
    _addressController =
        TextEditingController(text: widget.request.direccionPropiedad);
    _titleController =
        TextEditingController(text: widget.request.tituloSolicitud);
    _descriptionController =
        TextEditingController(text: widget.request.descripcionSolicitud);
    _priceController =
        TextEditingController(text: widget.request.precioCasa.toString());
    _gananciaController =
        TextEditingController(text: widget.request.gananciaEmpresa.toString());
    idSolicitud = widget.request.idSolicitud;
  }

  // Método para actualizar la información
  void _updateInfo() async {
    // Validar los campos
    if (_formKey.currentState?.validate() ?? false) {
      // Obtener los valores de los campos
      final title = _titleController.text;
      final descripcion = _descriptionController.text;
      final dirrecion = _addressController.text;
      final precio = double.parse(_priceController.text);
      final ganancia = double.parse(_gananciaController.text);
      // Enviar la solicitud
      final result = await _updateController.requestUpdate(
          title, descripcion, dirrecion, precio, ganancia, idSolicitud);
      // Mostrar un mensaje de éxito o error
      if (result == 1) {
        showAlertDialogScreen(
            'Éxito', 'Se ha enviando la operación exitosamente ', 3, context,
            () {
          context.go("/main", extra: 3);
        });
      } else if (result == 2) {
        showAlertDialog(
            'Error',
            'Revisar el formato de los campos, no se puede malas palabras por favor intenta de nuevo ',
            2,
            context);
      } else {
        showAlertDialog(
            'Error',
            'Ocurrió un error al enviar la solicitud. Por favor, intenta de nuevo.',
            2,
            context);
      }
    }
  }

  // Diseño de la pantalla
  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;
    // Estructura de la pantalla
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go("/main", extra: 3);
          },
        ),
      ),
      // Cuerpo de la pantalla
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Título y descripción
                Text(
                  "Agregar nueva solicitud",
                  style: AppStyles.headline5(context, colorTexto),
                ),
                const SizedBox(height: 10),
                Text(
                  "Por favor, complete los campos para agregar una nueva solicitud de servicio de venta de propiedades",
                  style: AppStyles.subtitle1(context),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  context: context,
                  hint: "Título",
                  isPassword: false,
                  icon: Icons.title,
                  key: const Key('titulo'),
                  validator: (value) =>
                      CustomValidator.validateTitle(value, 90, 'título'),
                  controller: _titleController,
                ),
                const SizedBox(height: 10),
                MyTextArea(
                  context: context,
                  hint: "Descripción de la propiedad",
                  icon: Icons.description,
                  key: const Key('descripcion'),
                  validator: (value) =>
                      CustomValidator.validateTitle(value, 900, 'Descripción'),
                  controller: _descriptionController,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  isPassword: false,
                  context: context,
                  hint: "Dirección de la propiedad",
                  icon: Icons.location_on,
                  key: const Key('direccion'),
                  validator: (value) =>
                      CustomValidator.validateTitle(value, 240, 'Dirección'),
                  controller: _addressController,
                ),
                MyTextField(
                    hint: 'Precio de la propiedad',
                    isPassword: false,
                    icon: Icons.price_change,
                    context: context,
                    key: const Key('precio'),
                    keyboardType: TextInputType.number,
                    validator: CustomValidator.validateDecimal,
                    controller: _priceController),
                const SizedBox(height: 10),
                MyTextField(
                    hint: 'Ganancia que se otorgará',
                    isPassword: false,
                    icon: Icons.price_check_sharp,
                    context: context,
                    key: const Key('ganancia'),
                    keyboardType: TextInputType.number,
                    validator: CustomValidator.validateDecimal,
                    controller: _gananciaController),
                const SizedBox(height: 20),
                // Botón para agregar solicitud
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    onPressed: _updateInfo,
                    text: "Actualizar solicitud",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
