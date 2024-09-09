// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/combo_box.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_area.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/data/controlers/preferences.dart';
import 'package:habbit_mobil_flutter/data/controlers/request_controlers.dart';
import 'package:habbit_mobil_flutter/data/models/category.dart';
import 'package:habbit_mobil_flutter/data/models/zone.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';
import 'package:go_router/go_router.dart';

// Pantalla para agregar una nueva solicitud
class NewRequest extends StatefulWidget {
  const NewRequest({super.key});

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest> {
  final _formKey = GlobalKey<FormState>();
  // Controladores para los campos de texto
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _gananciaController = TextEditingController();
  final RequestService _saveController = RequestService();
  // Listas de categorías y zonas
  List<Category> _categories = [];
  List<Zone> _zones = [];
  Zone? _selectedZone;
  Category? _selectedCategory;
  String? _selectedOption;

  // Método para cargar categorías y zonas
  @override
  void initState() {
    super.initState();
    _loadCategorieZonas();
    _selectedOption = 'Sí'; // Valor por defecto
  }

  // Método para cargar categorías y zonas
  Future<void> _loadCategorieZonas() async {
    try {
      final dataPreferences = DataPreferences();
      final categories = await dataPreferences.fetchCategories();
      final zones = await dataPreferences.fetchZones();
      setState(() {
        _categories = categories;
        _zones = zones;

        // Selecciona el primer elemento si no hay ninguno seleccionado.
        if (_categories.isNotEmpty && _selectedCategory == null) {
          _selectedCategory = _categories.first;
        }
        if (_zones.isNotEmpty && _selectedZone == null) {
          _selectedZone = _zones.first;
        }
      });
    } catch (e) { // En caso de error, muestra un mensaje
      showAlertDialog(
        'Error',
        'Ocurrió un error al cargar zonas y categorías. Por favor, intenta de nuevo.',
        2,
        context,
      );
    }
  }

  // Método para actualizar la información
  void _saveInfo() async {
    // Validar los campos
    if (_formKey.currentState?.validate() ?? false) {
      // Obtener los valores de los campos
      final title = _titleController.text;
      final descripcion = _descriptionController.text;
      final dirrecion = _addressController.text;
      final precio = int.parse(_priceController.text);
      final ganancia = int.parse(_gananciaController.text);
      // Enviar la solicitud
      final result = await _saveController.requestSave(
          title,
          descripcion,
          dirrecion,
          precio,
          ganancia,
          _selectedCategory?.id,
          _selectedZone?.id,
          _selectedOption);
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
                const SizedBox(height: 10),
                // Combobox de exclusividad
                MyComboBox<String>(
                  hint: 'Selecciona una opción',
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Sí',
                      child: Text('Sí'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'No',
                      child: Text('No'),
                    ),
                  ],
                  value: _selectedOption,
                  onChanged: (selectedOption) {
                    setState(() {
                      _selectedOption = selectedOption;
                    });
                  },
                ),
                const SizedBox(height: 10),
                // Combobox de categorías
                _categories.isEmpty
                    ? const CircularProgressIndicator()
                    : MyComboBox<Category>(
                        hint: 'Selecciona una categoría',
                        items: _categories.map((category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        value: _selectedCategory,
                        onChanged: (selectedCategory) {
                          setState(() {
                            _selectedCategory = selectedCategory;
                          });
                        },
                      ),
                const SizedBox(height: 10),
                // Combobox de zonas
                _zones.isEmpty
                    ? const CircularProgressIndicator()
                    : MyComboBox<Zone>(
                        hint: 'Selecciona una zona',
                        items: _zones.map((zone) {
                          return DropdownMenuItem<Zone>(
                            value: zone,
                            child: Text(zone.name),
                          );
                        }).toList(),
                        value: _selectedZone,
                        onChanged: (selectedZone) {
                          setState(() {
                            _selectedZone = selectedZone;
                          });
                        },
                      ),
                const SizedBox(height: 20),
                // Botón para agregar solicitud
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    onPressed: _saveInfo,
                    text: "Agregar solicitud",
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
