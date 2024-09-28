//Importacion de paquetes a utilizar
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart'; // Importa tu controlador
import 'package:habbit_mobil_flutter/data/controlers/prices.dart';

//Creación y construcción de stateful widget llamado price screen
class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  // Inicializa el rango con valores predeterminados que se actualizarán más tarde.
  var selectedRange = RangeValues(0, 0);
  // Inicializa los valores mínimo y máximo con 0.
  double minPrice = 0;
  double maxPrice = 0;
  // Inicializa isLoading en verdadero.
  bool isLoading = true;
  // Inicializa el controlador de estadísticas.
  final DataPrices _dataPreferences = DataPrices();
  // Inicializa el controlador de estadísticas.
  final EstadisticasController _estadisticasController =
      Get.put(EstadisticasController());

  @override
  void initState() {
    super.initState();

    // Creación para animación de la pantalla
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOut),
    );
    _fadeInController.forward();

    // Cargar el rango de precios desde la api
    _dataPreferences.fetchPrecioRange().then((range) {
      setState(() {
        minPrice = range.minimo;
        maxPrice = range.maximo;
        selectedRange = RangeValues(minPrice, maxPrice);
        isLoading = false;
      });
    }).catchError((error) {
      print('Error al cargar el rango de precios: $error');
      setState(() {
        isLoading = false;
      });
    });
  }

  //Funcion para enviar datos al controlador
  void _handlePrecio() async {
    // Valida el rango de precios seleccionado.
    String? validationError = CustomValidator.validatePriceRange(
      selectedRange.start.toDouble(),
      selectedRange.end.toDouble(),
    );
    // Si hay un error de validación, muestra una alerta.
    if (validationError != null) {
      showAlertDialog('Advertencia', validationError, 1, context);
    } else {
      _estadisticasController.actualizarPrecio(
        min: selectedRange.start.round().toDouble(),
        max: selectedRange.end.round().toDouble(),
      );
      context.push('/category');
    }
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
          horizontal: width * 0.05,
        ),
        child: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Muestra un indicador de carga mientras se obtienen los datos
            : Column(
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
                              vertical: height * 0,
                              horizontal: width * 0.01,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Elige el precio máximo y mínimo",
                                  style:
                                      AppStyles.headline5(context, colorTexto),
                                ),
                                SizedBox(height: height * 0.01),
                                Text(
                                  "Selecciona un precio máximo y un precio mínimo de los que están en el rango",
                                  style: AppStyles.subtitle1(context),
                                ),
                                SizedBox(height: height * 0.05),
                                RangeSlider(
                                  values: selectedRange,
                                  min: minPrice,
                                  max: maxPrice,
                                  onChanged: (RangeValues newRange) {
                                    setState(() {
                                      selectedRange = newRange;
                                    });
                                  },
                                  activeColor: Theme.of(context).primaryColor,
                                  inactiveColor: Colors.grey[300],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${selectedRange.start.round().toDouble()}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      "\$${selectedRange.end.round().toDouble()}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.42),
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomButton(
                                    onPressed: () {
                                      _handlePrecio();
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
