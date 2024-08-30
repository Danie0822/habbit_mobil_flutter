//Importacion de paquetes a utilizar
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/controlers/preferences.dart';
import 'package:habbit_mobil_flutter/data/models/zone.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart';

//Creación y construcción de stateful widget llamado Zona screen
class ZoneScreenUp extends StatefulWidget {
  const ZoneScreenUp({super.key});

  @override
  State<ZoneScreenUp> createState() => _ZoneScreenUpState();
}

class _ZoneScreenUpState extends State<ZoneScreenUp> with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

//Creacion de la lista de strings para los radio items
  List<Zone> _zoneItems = [];
  Zone? _selectedRadioItem;

  final EstadisticasController _estadisticasController =
      Get.put(EstadisticasController());

  @override
  void initState() {
    super.initState();

    //Creacion para animacion de la pantalla
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOut),
    );
    _fadeInController.forward();

    _fetchZone();
  }

//Funcion asincrona para manejar la respuesta del servidor.
Future<void> _fetchZone() async {
  try {
    // Obtenemos las zonas del controlador
    final zones = await DataPreferences().fetchZones();
    setState(() {
      _zoneItems = zones;

      Zone? selectedZone;

      // Verifica si _zoneItems no está vacío y hay un idZona en las estadísticas
      if (_zoneItems.isNotEmpty) {
        if (_estadisticasController.estadisticasBusquedas.idZona != 0) {
          selectedZone = _zoneItems.firstWhere(
            (zone) => zone.id == _estadisticasController.estadisticasBusquedas.idZona // Aquí se maneja la ausencia de coincidencias.
          );
        }
      }

      // Asigna el resultado a _selectedRadioItem
      _selectedRadioItem = selectedZone;
    });
  } catch (error) {
    print(error);
  }
}




  //Funcion para manejar los datos de las zonas
  void _handleZone() async {
    if (_selectedRadioItem == null) {
      showAlertDialog('Zona no seleccionada',
          'Selecciona un valor para la zona antes de continuar.', 1, context);
    } else {
      _estadisticasController.actualizarZone(idZona: _selectedRadioItem!.id);
      context.push('/thanks');
    }
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

// Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

//Incio de la construccion de la pantalla
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
                          //Widget que muestra el texto
                          Text(
                            "Actualización de zona",
                            style: AppStyles.headline5(context, colorTexto),
                          ),
                          SizedBox(height: height * 0.01),
                          //Widget que muestra el texto
                          Text(
                            "Selecciona una zona para mostrarte propiedades similares",
                            style: AppStyles.subtitle1(context),
                          ),
                          SizedBox(height: height * 0.02),
                          SizedBox(
                            height: height * 0.5,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (int i = 0; i < _zoneItems.length; i++)
                                    //Muestra la lista de radio button
                                    RadioListTile<Zone>(
                                      value: _zoneItems[i],
                                      groupValue: _selectedRadioItem,
                                      onChanged: (Zone? value) {
                                        setState(() {
                                          _selectedRadioItem = value;
                                        });
                                      },
                                      title: Text(_zoneItems[i].name),
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
                            //Widget del boton para seguir a la siguiente pantalla
                            alignment: Alignment.center,
                            child: CustomButton(
                              onPressed: () {
                                _handleZone();
                              },
                              text: "Terminar",
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
