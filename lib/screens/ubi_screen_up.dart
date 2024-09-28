import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/data/services/storage_service.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:habbit_mobil_flutter/data/controlers/search_statistics.dart';

class UbiScreenUp extends StatefulWidget {
  const UbiScreenUp({super.key});

  @override
  State<StatefulWidget> createState() => _UbiScreenStateUp();
}

class _UbiScreenStateUp extends State<UbiScreenUp> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kElSalvador = CameraPosition(
    target: LatLng(13.794185, -88.896530),
    zoom: 9.0,
  );

//Definimos los limites para El Salvador
  final LatLngBounds _bounds = LatLngBounds(
    southwest: LatLng(12.967816, -90.231934),
    northeast: LatLng(14.433046, -87.649403),
  );

  Marker? _selectedLocationMarker;
  String? _selectedLocationAddress;

  final EstadisticasController _estadisticasController =
      Get.put(EstadisticasController());

  @override
  void initState() {
    super.initState();
    _fetchData(); // Cargar las estadísticas antes de inicializar el mapa
  }

// Función modificada para cargar latitud y longitud de estadísticas y setear el marcador en el mapa
  void _fetchData() async {
    final estadisticas = await _estadisticasController.obtenerEstadisticas();
    _estadisticasController.estadisticasBusquedas = estadisticas;

    LatLng preferredLocation = LatLng(
      estadisticas.latitudPreferida,
      estadisticas.longitudPreferida,
    );

    // Colocar el marcador en la ubicación preferida
    setState(() {
      _selectedLocationMarker = Marker(
        markerId: const MarkerId('preferred-location'),
        position: preferredLocation,
      );

      // Cambiar la cámara a la ubicación preferida
      _moveCamera(preferredLocation);

      // Cargar y almacenar la dirección de la ubicación preferida
      _getAddressFromLatLng(preferredLocation);
    });
  }

// Mover la cámara a la nueva ubicación
  void _moveCamera(LatLng location) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newCameraPosition =
        CameraPosition(target: location, zoom: 15);
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

// Obtener la dirección a partir de las coordenadas y almacenarla
  void _getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _selectedLocationAddress =
              "${place.street}, ${place.locality}, ${place.country}";
        });

        // Actualizar la dirección en las estadísticas
        _estadisticasController.estadisticasBusquedas.ubicacionPreferida =
            _selectedLocationAddress!;
      } else {
        setState(() {
          _selectedLocationAddress = "Dirección no encontrada";
        });
      }
    } catch (e) {
      setState(() {
        _selectedLocationAddress = "Error al obtener la dirección";
      });
      print(e);
    }
  }

//Para manejar ubicacion al mover el marcador
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
        print(e);
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
  void _handleUbiUpdate() async {
    try {
      final clientId = await StorageService.getClientId();
      if (clientId == null) {
        throw Exception('No se pudo obtener el ID del cliente.');
      }

      if (_selectedLocationMarker != null && _selectedLocationAddress != null) {
        final formData = {
          'id_cliente': clientId,
          'ubicacion_preferida': _selectedLocationAddress,
          'latitud_preferida': _selectedLocationMarker!.position.latitude,
          'longitud_preferida': _selectedLocationMarker!.position.longitude
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
      } else {
        showAlertDialog(
            'Ubicación no seleccionada',
            'Por favor selecciona una ubicación antes de continuar.',
            1,
            context);
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
            horizontal: width * 0.05, vertical: height * 0.03),
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
                  _handleUbiUpdate();
                },
                text: "Guardar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
