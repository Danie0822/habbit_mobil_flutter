//Importacion de paquetes a utilizar
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart'; // Importa tu controlador
import 'package:habbit_mobil_flutter/data/controlers/prices.dart';

//Creación y construcción de stateful widget llamado price screen
class PriceScreenUp extends StatefulWidget {
  const PriceScreenUp({super.key});

  @override
  State<PriceScreenUp> createState() => _PriceScreenStateUp();
}

class _PriceScreenStateUp extends State<PriceScreenUp>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  // Inicializa el rango con valores predeterminados que se actualizarán más tarde.
  var selectedRange = RangeValues(0, 0);
  // Inicializa los valores mínimo y máximo con 0.
  double minPrice = 0;
  double maxPrice = 0;
  // Inicializa isLoading en true para mostrar un indicador de carga.
  bool isLoading = true;
  // Inicializa el controlador de precios y estadísticas.
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

    _fetchData();
  }

  //Funcion para cerrar el controlador de animación
  void _fetchData() async {
    final estadisticas = await _estadisticasController.obtenerEstadisticas();
    //print('Datos de EstadisticasBusquedas: $estadisticas');
    _estadisticasController.estadisticasBusquedas = estadisticas;

    // Luego, llama a _fetchPrices
    await _fetchPrices();
  }

  //Funcion para cerrar el controlador de animación
  Future<void> _fetchPrices() async {
    try {
      // Cargar el rango de precios desde la API
      _dataPreferences.fetchPrecioRange().then((range) {
        setState(() {
          minPrice = range.minimo; // Asegúrate de que estos valores existan
          maxPrice = range.maximo;

          // Obtener los valores de precios seleccionados del controlador
          final selectedPriceMin =
              _estadisticasController.estadisticasBusquedas.precioMin;
          final selectedPriceMax =
              _estadisticasController.estadisticasBusquedas.precioMax;

          // Asegurar que los precios seleccionados estén dentro del rango
          selectedRange = RangeValues(
            selectedPriceMin.clamp(minPrice, maxPrice),
            selectedPriceMax.clamp(minPrice, maxPrice),
          );

          isLoading = false;
        });
      }).catchError((error) {
        print('Error al cargar el rango de precios: $error');
        setState(() {
          isLoading = false;
        });
      });
    } catch (error) {
      print(error);
    }
  }

  //Funcion para enviar datos al controlador
  void _handlePrecioUpdate() async {
    try {
      // Obtener el ID del cliente del almacenamiento local
      final clientId = await StorageService.getClientId();
      // Si no se puede obtener el ID del cliente, lanza una excepción
      if (clientId == null) {
        /// Lanza una excepción si no se puede obtener el ID del cliente.
        throw Exception('No se pudo obtener el ID del cliente.');
      }
      // Validar el rango de precios seleccionado
      String? validationError = CustomValidator.validatePriceRange(
        selectedRange.start.toDouble(),
        selectedRange.end.toDouble(),
      );
      // Si hay un error de validación, muestra un cuadro de diálogo de advertencia
      if (validationError != null) {
        showAlertDialog('Advertencia', validationError, 1, context);
      } else {
        // Si no hay errores de validación, envía los datos al controlador
        final formData = {
          'id_cliente': clientId,
          'precio_min': selectedRange.start.toDouble(),
          'precio_max': selectedRange.end.toDouble(),
        };
        // Actualiza las preferencias de precios en la API
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
      print(error);
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
            context.push('/editPreferences');
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
                                      _handlePrecioUpdate();
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
