import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/combo_box.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_area.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field.dart';
import 'package:habbit_mobil_flutter/data/controlers/preferences.dart';
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
  // Listas de categorías y zonas
  List<Category> _categories = [];
  List<Zone> _zones = [];
  Zone? _selectedZone;
  Category? _selectedCategory;

  // Método para cargar categorías y zonas
  @override
  void initState() {
    super.initState();
    _loadCategorieZonas();
  }
  // Método para cargar categorías y zonas
  Future<void> _loadCategorieZonas() async {
    try {
      final dataPreferences = DataPreferences();
      final categories = await dataPreferences.fetchCategories();
      final zonas = await dataPreferences.fetchZones();
      setState(() {
        _categories = categories;
        _zones = zonas;
      });
    } catch (e) {
      showAlertDialog(
          'Error',
          'Ocurrió un error al cargar zonas y categorias. Por favor, intenta de nuevo.',
          2,
          // ignore: use_build_context_synchronously
          context);
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
            context.pop();
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
                  hint: "Descripción",
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
                  hint: "Dirección",
                  icon: Icons.location_on,
                  key: const Key('direccion'),
                  validator: (value) =>
                      CustomValidator.validateTitle(value, 240, 'Dirección'),
                  controller: _descriptionController,
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
                    onPressed: () {
                      // Acción al presionar el botón
                    },
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
