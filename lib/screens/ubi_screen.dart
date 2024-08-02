import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart'; // Importa Get para usar el controlador
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart'; // Importa tu controlador

class UbiScreen extends StatefulWidget {
  const UbiScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UbiScreenState();
}

class _UbiScreenState extends State<UbiScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kElSalvador = CameraPosition(
    target: LatLng(13.794185, -88.896530),
    zoom: 9.0,
  );

  final LatLngBounds _bounds = LatLngBounds(
    southwest: LatLng(12.967816, -90.231934), // Coordenada SW de El Salvador
    northeast: LatLng(14.433046, -87.649403), // Coordenada NE de El Salvador
  );

  Marker? _selectedLocationMarker;
  String? _selectedLocationAddress;

  final EstadisticasController _estadisticasController =
      Get.put(EstadisticasController());

  //Alerta para mostrar en validaciones
  void _showAlertDialog(BuildContext context, String text1, String text2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text1),
          content: Text(text2),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onMapTapped(LatLng location) async {
    if (_bounds.contains(location)) {
      setState(() {
        _selectedLocationMarker = Marker(
          markerId: const MarkerId('selected-location'),
          position: location,
        );
        _selectedLocationAddress = "Cargando dirección...";
      });

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          setState(() {
            _selectedLocationAddress =
                "${place.street}, ${place.locality}, ${place.country}";
          });
        } else {
          setState(() {
            _selectedLocationAddress = "Dirección no encontrada";
          });
        }
      } catch (e) {
        setState(() {
          _selectedLocationAddress = "Error al obtener la dirección";
        });
      }
    } else {
      _showAlertDialog(context, 'Advertencia',
          'La ubicación seleccionada está fuera del área permitida.');
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
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ubicación", style: AppStyles.headline5(context, colorTexto)),
            SizedBox(height: height * 0.01),
            Text("Selecciona tu ubicación preferida",
                style: AppStyles.subtitle1(context)),
            SizedBox(height: height * 0.01),
            SizedBox(
              height: height * 0.5,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kElSalvador,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _selectedLocationMarker != null
                    ? {_selectedLocationMarker!}
                    : {},
                onTap: _onMapTapped,
                // Limita la vista del mapa a los límites definidos
                cameraTargetBounds: CameraTargetBounds(_bounds),
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              _selectedLocationAddress ?? "No hay una ubicación seleccionada",
              style: AppStyles.subtitle1(context)?.copyWith(color: colorTexto),
            ),
            SizedBox(height: height * 0.08),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                onPressed: () {
                  if (_selectedLocationMarker != null &&
                      _selectedLocationAddress != null) {
                    _estadisticasController.actualizarUbicacion(
                      ubicacion: _selectedLocationAddress!,
                      latitud: _selectedLocationMarker!.position.latitude,
                      longitud: _selectedLocationMarker!.position.longitude,
                    );
                    context.push('/price');
                  } else {
                    _showAlertDialog(context, 'Ubicación no seleccionada',
                        'Por favor selecciona una ubicación antes de continuar.');
                  }
                },
                text: "Siguiente",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
