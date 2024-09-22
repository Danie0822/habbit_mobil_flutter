import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart';
import 'package:habbit_mobil_flutter/data/controlers/prices.dart';
import 'package:habbit_mobil_flutter/data/controlers/slider.dart';
import 'package:habbit_mobil_flutter/utils/validators/validaciones.dart';
import 'package:habbit_mobil_flutter/data/models/category.dart';
import 'package:habbit_mobil_flutter/data/models/zone.dart';
import 'package:habbit_mobil_flutter/data/models/slider.dart';
import 'package:habbit_mobil_flutter/data/controlers/preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class RecommendOptionScreen extends StatefulWidget {
  const RecommendOptionScreen({super.key});

  @override
  State<RecommendOptionScreen> createState() => RecommendOptionScreenState();
}

class RecommendOptionScreenState extends State<RecommendOptionScreen> {
  var selectedRange = RangeValues(0, 0);
  double minPrice = 0;
  double maxPrice = 0;
  double latitud = 0.0;
  double longitud = 0.0;
  double _distance =
      50.0; // Default value for distance (for El Salvador length)
  bool isLoading = true;
  int selectedEstadoPropiedad = 0; // 0: Ambos, 1: Venta, 2: Alquiler
  int selectedTipoPropiedad = 0; // 0: Ambos, 1: Proyecto, 2: Inmueble
  bool isLoadingRequest =
      false; // Nuevo booleano para manejar el estado de carga

  final DataPrices _dataPreferences = DataPrices();
  final SliderServices _sliderServices = SliderServices();
  final EstadisticasController _estadisticasController =
      Get.put(EstadisticasController());
  final DataPreferences _preferences = DataPreferences();

  List<Category> _categories = [];
  List<Zone> _zones = [];
  Category? _selectedCategory;
  Zone? _selectedZone;

  @override
  void initState() {
    super.initState();
    _loadDataSequentially();
  }

  // Function to load data in sequence (Price -> Zone -> Category)
  Future<void> _loadDataSequentially() async {
    try {
      // Paso 1: Obtener rango de precios
      await _loadPriceRange();

      // Paso 2: Obtener zonas
      await _loadZones();

      // Paso 3: Obtener categorías
      await _loadCategories();

      _getCurrentLocation();

      setState(() {
        isLoading = false; // Finaliza la carga
      });
    } catch (e) {
      print('Error durante la carga secuencial: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to fetch the price range
  Future<void> _loadPriceRange() async {
    final range = await _dataPreferences.fetchPrecioRange();
    setState(() {
      minPrice = range.minimo;
      maxPrice = range.maximo;
      selectedRange = RangeValues(minPrice, maxPrice);
    });
  }

  Future<void> _getCurrentLocation() async {
    // Verifica si los permisos están otorgados
    var status = await Permission.location.status;

    // Si el permiso está denegado o restringido, solicítalo
    if (status.isDenied || status.isRestricted) {
      // Solicita el permiso
      if (await Permission.location.request().isGranted) {
        // El permiso ha sido otorgado, obtener la ubicación
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        latitud = position.latitude;
        longitud = position.longitude;
      } else {
        // El permiso fue denegado permanentemente o no se otorgó
        print("Permiso de ubicación denegado.");
        // Opcional: Mostrar un mensaje o abrir configuración de la app
      }
    } else {
      // Los permisos ya están otorgados, obtener la ubicación
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitud = position.latitude;
      longitud = position.longitude;
    }
  }

  // Function to fetch zones
  Future<void> _loadZones() async {
    final zones = await _preferences.fetchZones();
    setState(() {
      _zones = [Zone(id: 0, name: "Todo"), ...zones];
      _selectedZone = _zones[0];
    });
  }

  // Function to fetch categories
  Future<void> _loadCategories() async {
    final categories = await _preferences.fetchCategories();
    setState(() {
      _categories = [Category(id: 0, name: "Todo"), ...categories];
      _selectedCategory = _categories[0];
    });
  }

  // Function to handle the price range selection
  void _handlePrecio() async {
    String? validationError = CustomValidator.validatePriceRange(
      selectedRange.start.toDouble(),
      selectedRange.end.toDouble(),
    );

    if (validationError != null) {
      showAlertDialog('Advertencia', validationError, 1, context);
    } else {
      _estadisticasController.actualizarPrecio(
        min: selectedRange.start.round().toDouble(),
        max: selectedRange.end.round().toDouble(),
      );
    }
  }

  void _handleConfirmar() {
    setState(() {
      isLoadingRequest = true; // Muestra el indicador de carga
    });
    final int selectedCategoryId = _selectedCategory?.id ?? 0;
    final int selectedZoneId = _selectedZone?.id ?? 0;
    final double precioMin = selectedRange.start;
    final double precioMax = selectedRange.end;
    final double distancia = _distance;
    final int selectedEstadoPropiedadValue = selectedEstadoPropiedad;
    final int selectedTipoPropiedadValue = selectedTipoPropiedad;

    // Enviar estos datos a la API o realizar la acción necesaria
    final Future<List<SliderResponse>> cards = _sliderServices.cargarCards(
      selectedZoneId,
      selectedCategoryId,
      precioMin,
      precioMax,
      distancia,
      selectedEstadoPropiedadValue,
      selectedTipoPropiedadValue,
      latitud,
      longitud,
    );

    cards.then((cardList) {
      if (cardList.isNotEmpty) {
        context.push('/slider',
            extra: cardList); // Asegúrate de que cardList no sea null o vacío
      } else {
        showAlertDialog(
          'Advertencia',
          'No se encontró ninguna propiedad con ese criterio, vuelve a intentarlo más tarde.',
          1,
          context,
        );
      }
    }).catchError((error) {
      // Si la lista está vacía, muestra un mensaje en un modal
      _showModal(context,
          'No se encontró ninguna propiedad con ese criterio, vuelve a intentarlo más tarde.');
      print('Error cargando las tarjetas: $error');
    });
    setState(() {
      isLoadingRequest = false; // Oculta el indicador de carga
    });
  }

  void _showModal(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mensaje'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Widget buildToggleButton(
      String label, int value, int groupValue, Function(int) onChanged) {
    final Color primaryBackground = ThemeUtils.getColorBasedOnBrightness(
        context, whiteColor, contenedorMensajeDark);

    final Color borde = ThemeUtils.getColorBasedOnBrightness(
        context, Colors.black, iconLightColor);

    final Color text =
        ThemeUtils.getColorBasedOnBrightness(context, Colors.black, whiteColor);

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 22), // Ajuste del padding
        decoration: BoxDecoration(
          color: groupValue == value ? primaryColorAzul : primaryBackground,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: groupValue == value ? Colors.transparent : borde,
            width: 2,
          ),
          boxShadow: [
            if (groupValue == value)
              BoxShadow(
                color: primaryColorAzul.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: groupValue == value ? Colors.white : text,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildToggleButtonsGroup(
      List<String> labels, int groupValue, Function(int) onChanged) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Habilita el scroll vertical
      child: Wrap(
        spacing: 10, // Espaciado horizontal entre botones
        runSpacing: 10, // Espaciado vertical si los botones se desbordan
        children: labels.asMap().entries.map((entry) {
          int idx = entry.key;
          String label = entry.value;
          return buildToggleButton(label, idx, groupValue, onChanged);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Theme-based colors
    final Color primaryBackground = ThemeUtils.getColorBasedOnBrightness(
        context, whiteColor, almostBlackColor);
    final Color primaryTextColor = ThemeUtils.getColorBasedOnBrightness(
        context, almostBlackColor, lightTextColor);
    final Color titleColor = ThemeUtils.getColorBasedOnBrightness(
        context, primaryColorAzul, lightTextColor);
    final Color secondaryTextColor = ThemeUtils.getColorBasedOnBrightness(
        context, almostBlackColor, lightTextColor);

    // Active (selected) and inactive (unselected) slider colors
    final Color sliderActiveColor = ThemeUtils.getColorBasedOnBrightness(
        context, primaryColorAzul, primaryColorAzul);
    final Color sliderInactiveColor = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeDark, colorBackGroundMessageWidget);

    return Scaffold(
      backgroundColor: primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          // Se añade el scroll
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header con texto y icono de información
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // Para que el texto pueda hacer salto de línea
                            child: Text(
                              '¡Complete lo siguiente con lo que usted desea!',
                              style: TextStyle(
                                fontSize: 28, // Texto más grande
                                fontWeight: FontWeight.bold, // Negrita
                                color: titleColor,
                              ),
                              softWrap: true, // Permite saltos de línea
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      // Estado de Propiedad
                      Text(
                        'Seleccione el estado de propiedad',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildToggleButton('Ambos', 0, selectedEstadoPropiedad,
                              (value) {
                            setState(() {
                              selectedEstadoPropiedad = value;
                            });
                          }),
                          buildToggleButton('Venta', 1, selectedEstadoPropiedad,
                              (value) {
                            setState(() {
                              selectedEstadoPropiedad = value;
                            });
                          }),
                          buildToggleButton(
                              'Alquiler', 2, selectedEstadoPropiedad, (value) {
                            setState(() {
                              selectedEstadoPropiedad = value;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 36),

                      // Tipo de Propiedad
                      Text(
                        'Seleccione el tipo de propiedad',
                        style: TextStyle(
                          fontSize: 22, // Texto más grande
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildToggleButton('Ambos', 0, selectedTipoPropiedad,
                              (value) {
                            setState(() {
                              selectedTipoPropiedad = value;
                            });
                          }),
                          buildToggleButton(
                              'Proyecto', 1, selectedTipoPropiedad, (value) {
                            setState(() {
                              selectedTipoPropiedad = value;
                            });
                          }),
                          buildToggleButton(
                              'Inmueble', 2, selectedTipoPropiedad, (value) {
                            setState(() {
                              selectedTipoPropiedad = value;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 36),

                      // Menú desplegable de categorías
                      Text(
                        'Seleccione una categoría',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 24, // Texto más grande
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonHideUnderline(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: ThemeUtils.getColorBasedOnBrightness(
                                context,
                                const Color.fromARGB(255, 243, 241, 241),
                                contenedorMensajeDark), // Cambia según el modo
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ThemeUtils.getColorBasedOnBrightness(
                                  context,
                                  Colors.grey.shade400,
                                  Colors.grey
                                      .shade700), // Bordes más oscuros en modo oscuro
                              width: 1,
                            ),
                          ),
                          child: DropdownButton<Category>(
                            value: _selectedCategory,
                            items: _categories.map((Category category) {
                              return DropdownMenuItem<Category>(
                                value: category,
                                child: Text(
                                  category.name,
                                  style: TextStyle(
                                    color: ThemeUtils.getColorBasedOnBrightness(
                                        context,
                                        secondaryTextColor,
                                        lightTextColor), // Cambia el color del texto según el tema
                                    fontSize: 18, // Tamaño de texto mayor
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (Category? newValue) {
                              setState(() {
                                _selectedCategory = newValue;
                              });
                            },
                            icon: Icon(Icons.arrow_drop_down,
                                color: ThemeUtils.getColorBasedOnBrightness(
                                    context, Colors.blue, lightTextColor),
                                size: 28), // Ícono más visible
                            isExpanded: true, // Ocupa el ancho completo
                            dropdownColor: ThemeUtils.getColorBasedOnBrightness(
                                context,
                                Colors.white,
                                almostBlackColor), // Cambia el fondo del dropdown según el tema
                            style: TextStyle(
                                fontSize: 18,
                                color: ThemeUtils.getColorBasedOnBrightness(
                                    context,
                                    Colors.black,
                                    lightTextColor)), // Estilo del texto
                            borderRadius: BorderRadius.circular(
                                12), // Bordes redondeados en el menú
                            elevation: 8, // Añadir sombra
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Menú desplegable de zonas
                      Text(
                        'Seleccione una zona',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 24, // Texto más grande
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonHideUnderline(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: ThemeUtils.getColorBasedOnBrightness(
                                context,
                                const Color.fromARGB(255, 243, 241, 241),
                                contenedorMensajeDark), // Fondo cambia según el modo
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ThemeUtils.getColorBasedOnBrightness(
                                  context,
                                  Colors.grey.shade400,
                                  Colors.grey
                                      .shade700), // Bordes más oscuros en modo oscuro
                              width: 1,
                            ),
                          ),
                          child: DropdownButton<Zone>(
                            value: _selectedZone,
                            items: _zones.map((Zone zone) {
                              return DropdownMenuItem<Zone>(
                                value: zone,
                                child: Text(
                                  zone.name,
                                  style: TextStyle(
                                    color: ThemeUtils.getColorBasedOnBrightness(
                                        context,
                                        secondaryTextColor,
                                        lightTextColor), // Cambia el color del texto según el tema
                                    fontSize: 18, // Tamaño de texto mayor
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (Zone? newValue) {
                              setState(() {
                                _selectedZone = newValue;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: ThemeUtils.getColorBasedOnBrightness(
                                  context,
                                  Colors.blue,
                                  lightTextColor), // Ícono más visible
                              size: 28,
                            ),
                            isExpanded: true, // Ocupa el ancho completo
                            dropdownColor: ThemeUtils.getColorBasedOnBrightness(
                                context,
                                Colors.white,
                                almostBlackColor), // Fondo del dropdown cambia según el modo
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeUtils.getColorBasedOnBrightness(
                                  context,
                                  Colors.black,
                                  lightTextColor), // Estilo del texto según el tema
                            ),
                            borderRadius: BorderRadius.circular(
                                12), // Bordes redondeados en el menú
                            elevation: 8, // Sombra
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Rango de precios
                      Text(
                        'Ponga un rango de precios',
                        style: TextStyle(
                          fontSize: 22, // Texto más grande
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${selectedRange.start.round().toDouble()}',
                            style: TextStyle(color: secondaryTextColor),
                          ),
                          Text(
                            '\$${selectedRange.end.round().toDouble()}',
                            style: TextStyle(color: secondaryTextColor),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: sliderActiveColor,
                          inactiveTrackColor: sliderInactiveColor,
                          thumbColor: primaryColorAzul,
                          overlayColor: sliderActiveColor.withOpacity(0.2),
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 10.0),
                          overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 20.0),
                        ),
                        child: RangeSlider(
                          values: selectedRange,
                          min: minPrice,
                          max: maxPrice,
                          divisions: 50,
                          labels: RangeLabels(
                            '\$${selectedRange.start.toStringAsFixed(2)}',
                            '\$${selectedRange.end.toStringAsFixed(2)}',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              selectedRange = values;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Rango de distancia
                      Text(
                        'Ponga un rango de distancia',
                        style: TextStyle(
                          fontSize: 22, // Texto más grande
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('${_distance.round()} km',
                          style: TextStyle(color: secondaryTextColor)),
                      Slider(
                        value: _distance,
                        min: 0,
                        max: 270, // Longitud de El Salvador
                        divisions: 27,
                        label: '${_distance.round()} km',
                        activeColor: sliderActiveColor,
                        inactiveColor: sliderInactiveColor,
                        onChanged: (double value) {
                          setState(() {
                            _distance = value;
                          });
                        },
                      ),
                      const SizedBox(height: 36),
                      isLoadingRequest // Mostrar indicador de carga si está cargando
                          ? const Center(child: CircularProgressIndicator())
                          :
                          // Botón de confirmación
                          Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: sliderActiveColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 60,
                                    vertical: 15,
                                  ),
                                ),
                                onPressed: _handleConfirmar,
                                child: const Text(
                                  '¡Descubrir!',
                                  style: TextStyle(
                                      color: normalText, fontSize: 18),
                                ),
                              ),
                            ),

                      const SizedBox(height: 20),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
