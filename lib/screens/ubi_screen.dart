import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart';

class UbiScreen extends StatefulWidget {
  const UbiScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UbiScreenState();
}

class _UbiScreenState extends State<UbiScreen> {
  // Controlador para el mapa
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // Posición inicial del mapa
  static const CameraPosition _kElSalvador = CameraPosition(
    target: LatLng(13.794185, -88.896530),
    zoom: 9.0,
  );

//Definimos los limites para El Salvador
  final LatLngBounds _bounds = LatLngBounds(
    southwest:
        LatLng(12.967816, -90.231934), // Coordenada Sur y Oeste de El Salvador
    northeast:
        LatLng(14.433046, -87.649403), // Coordenada Nor Este de El Salvador
  );
  // Marcador de ubicación seleccionada
  Marker? _selectedLocationMarker;
  // Dirección de la ubicación seleccionada
  String? _selectedLocationAddress;
  // Controlador de estadísticas
  final EstadisticasController _estadisticasController =
      Get.put(EstadisticasController());

//Para manejar ubicacion al mover el marcador
  void _onMapTapped(LatLng location) async {
    // Verificar si la ubicación seleccionada está dentro de los límites
    if (_bounds.contains(location)) {
      setState(() {
        // Actualizar el marcador de la ubicación seleccionada
        _selectedLocationMarker = Marker(
          markerId: const MarkerId('selected-location'),
          position: location,
        );
        _selectedLocationAddress = "Cargando dirección...";
      });

      try {
        // Obtener la dirección de la ubicación seleccionada
        List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);
        // Verificar si se encontró una dirección
        if (placemarks.isNotEmpty) {
          // Obtener la primera dirección encontrada
          Placemark place = placemarks.first;
          // Actualizar la dirección de la ubicación seleccionada
          setState(() {
            // Actualizar la dirección de la ubicación seleccionada
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
      showAlertDialog(
          'Advertencia',
          'La ubicación seleccionada está fuera del área permitida.',
          1,
          context);
    }
  }

  //Manejemos la ubicacion
  void _handleUbi() async {
    // Verificar si se ha seleccionado una ubicación
    if (_selectedLocationMarker != null && _selectedLocationAddress != null) {
      // Actualizar la ubicación en las estadísticas
      _estadisticasController.actualizarUbicacion(
        ubicacion: _selectedLocationAddress!,
        latitud: _selectedLocationMarker!.position.latitude,
        longitud: _selectedLocationMarker!.position.longitude,
      );
      context.push('/price');
    } else {
      showAlertDialog('Ubicación no seleccionada',
          'Por favor selecciona una ubicación antes de continuar.', 1, context);
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.1),
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
            Flexible(
              child: Text(
                _selectedLocationAddress ?? "No hay una ubicación seleccionada",
                style:
                    AppStyles.subtitle1(context)?.copyWith(color: colorTexto),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
              ),
            ),
            SizedBox(height: height * 0.08),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                onPressed: () {
                  _handleUbi();
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
