import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/controlers/preferences.dart';
import 'package:habbit_mobil_flutter/data/models/category.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
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

    _fetchCategories();
  }

//Funcion para cargar los datos de categorias
  Future<void> _fetchCategories() async {
    try {
      final categories = await DataPreferences().fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (error) {
      print(error);
    }
  }

  //Funcion para manejar los datos de la categoria
  void _handleCategory() async {
    if (_selectedRadioItem == null) {
      showAlertDialog(
          'Categoría no seleccionada',
          'Selecciona un valor para la categoría  antes de continuar.',
          1,
          context);
    } else {
      _estadisticasController.actualizarCat(idCat: _selectedRadioItem!.id);
      context.push('/zone');
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
            context.pop();
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
                                _handleCategory();
                              },
                              text: "Siguiente",
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
