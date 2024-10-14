import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/controlers/preferences.dart';
import 'package:habbit_mobil_flutter/data/models/category.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart';

class CategoryScreenUp extends StatefulWidget {
  const CategoryScreenUp({super.key});

  @override
  State<CategoryScreenUp> createState() => _CategoryScreenStateUp();
}

class _CategoryScreenStateUp extends State<CategoryScreenUp>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  List<Category> _categories = [];
  Category? _selectedRadioItem;

  final EstadisticasController _estadisticasController =
      Get.put(EstadisticasController());

  @override
  void initState() {
    super.initState();

    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOut),
    );
    _fadeInController.forward();

    _fetchData();
  }

//Funcion que se encarga primero de cargar las estadisticas y luego se setearlo para llena la lista
  void _fetchData() async {
    final estadisticas = await _estadisticasController.obtenerEstadisticas();
    _estadisticasController.estadisticasBusquedas = estadisticas;

    // Luego, llama a _categories
    await _fetchCategories();
  }

//Funcion para cargar los datos de categorias
  Future<void> _fetchCategories() async {
    try {
      final categories = await DataPreferences().fetchCategories();
      setState(() {
        _categories = categories;

        final selectedIdCategory =
            _estadisticasController.estadisticasBusquedas.idCategoria;

        if (selectedIdCategory != 0) {
          _selectedRadioItem = _categories.firstWhere(
            (category) => category.id == selectedIdCategory,
            orElse: () => _categories[0],
          );
        } else {
          _selectedRadioItem = _categories[0];
        }
      });
    } catch (error) {
    }
  }

  //Funcion para manejar los datos de la categoria
  void _handleCategoryUpdate() async {
    try {
      //Obtener el ID del cliente
      final clientId = await StorageService.getClientId();

      if (clientId == null) {
        throw Exception('No se pudo obtener el ID del cliente.');
      }

      if (_selectedRadioItem == null) {
        showAlertDialog(
          'Zona no seleccionada',
          'Selecciona un valor para la zona antes de continuar.',
          1,
          context,
        );
      } else {
        final formData = {
          'id_cliente': clientId,
          'id_categoria': _selectedRadioItem?.id,
        };

        // Llamar al controlador para actualizar las preferencias
        final success =
            await _estadisticasController.updatePreferences(formData);

        if (success) {
          showAlertDialogScreen(
            'Éxito',
            'Los datos fueron modificados con éxito.',
            3,
            context,
            () {
              context.go('/editPreferences');
            },
          );
        } else {
          showAlertDialog(
            'Error',
            'No se pudo actualizar los datos.',
            1,
            context,
          );
        }
      }
    } catch (error) {
      // Manejo de errores
      showAlertDialog(
        'Error',
        'Hubo un problema al actualizar los datos.',
        1,
        context,
      );
    }
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.push('/editPreferences');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0,
          horizontal: width * 0.03,
        ),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _fadeInAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeInAnimation.value,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Elige una categoría",
                            style: AppStyles.headline5(context, colorTexto),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Selecciona una categoría para mostrarte propiedades similares",
                            style: AppStyles.subtitle1(context),
                          ),
                          SizedBox(height: height * 0.02),
                          SizedBox(
                            height: height * 0.5,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (int i = 0; i < _categories.length; i++)
                                    RadioListTile<Category>(
                                      value: _categories[i],
                                      groupValue: _selectedRadioItem,
                                      onChanged: (Category? value) {
                                        setState(() {
                                          _selectedRadioItem = value;
                                        });
                                      },
                                      title: Text(_categories[i].name),
                                      activeColor: colorTextYellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.1),
                          Align(
                            alignment: Alignment.center,
                            child: CustomButton(
                              onPressed: () {
                                _handleCategoryUpdate();
                              },
                              text: "Guardar",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
