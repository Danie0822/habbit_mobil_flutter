import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:habbit_mobil_flutter/data/models/map.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:habbit_mobil_flutter/data/controlers/map.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:go_router/go_router.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Marker? _currentLocationMarker;
  LatLng? _currentPosition;
  Set<Marker> _propertyMarkers = {}; // Marcadores de propiedades
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(13.68935, -89.18718), // Coordenadas iniciales
    zoom: 20.0, // Nivel de zoom ajustado
  );

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

        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _currentLocationMarker = Marker(
            markerId: const MarkerId("current_location"),
            position: _currentPosition!,
            infoWindow: const InfoWindow(title: 'Tu ubicación'),
          );
        });

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
      } else {
        // El permiso fue denegado permanentemente o no se otorgó
        print("Permiso de ubicación denegado.");
        // Opcional: Mostrar un mensaje o abrir configuración de la app
      }
    } else {
      // Los permisos ya están otorgados, obtener la ubicación
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _currentLocationMarker = Marker(
          markerId: const MarkerId("current_location"),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: 'Tu ubicación'),
        );
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
    }
  }

  Future<void> _fetchProperties(LatLngBounds bounds) async {
    try {
      final int markerSize = 150; // Tamaño fijo del marcador (puedes ajustarlo)
      double borderWidth = 8.0; // Tamaño del borde

      List<MapResponse> properties = await MapService().cargarPropeidad(
        bounds.northeast.latitude,
        bounds.northeast.longitude,
        bounds.southwest.latitude,
        bounds.southwest.longitude,
      );

      Set<Marker> newMarkers =
          (await Future.wait(properties.map((property) async {
        print('property: $property');
        Uint8List markerIcon = await _getCustomMarkerWithBorder(
          '${Config.imagen}${property.imageUrl}',
          markerSize,
          borderWidth,
        );
        return Marker(
          markerId: MarkerId(property.idProperty.toString()),
          position: LatLng(property.latitude!, property.longitude!),
          infoWindow: InfoWindow(title: property.title),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () {
            _showPropertyDetails(property);
          },
        );
      })))
              .toSet();

      setState(() {
        _propertyMarkers = newMarkers;
      });
    } catch (e) {
      print('Error al cargar propiedades: $e');
    }
  }

  Future<Uint8List> _getCustomMarkerWithBorder(
      String imageUrl, int size, double borderWidth) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    final Uint8List bytes = response.bodyBytes;

    final ui.Codec codec =
        await ui.instantiateImageCodec(bytes, targetWidth: size);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Dibujar círculo azul
    final Paint borderPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    final double radius = size / 2;
    canvas.drawCircle(Offset(radius, radius), radius, borderPaint);

    // Dibujar imagen dentro del círculo
    final double imageRadius = radius - borderWidth;
    final Rect imageRect =
        Rect.fromCircle(center: Offset(radius, radius), radius: imageRadius);
    canvas.clipPath(Path()..addOval(imageRect));
    canvas.drawImageRect(
      frameInfo.image,
      Rect.fromLTWH(0, 0, frameInfo.image.width.toDouble(),
          frameInfo.image.height.toDouble()),
      imageRect,
      Paint(),
    );

    final ui.Image finalImage =
        await pictureRecorder.endRecording().toImage(size, size);
    final ByteData? byteData =
        await finalImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void _showPropertyDetails(MapResponse property) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color colorTexto = isDarkMode ? colorTextField : textColorNegro;
    final Color colorFondoModal = isDarkMode ? Colors.grey[900]! : Colors.white;
    final Color colorTextoButton = isDarkMode ? colorTextField : primaryColor;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colorFondoModal, // Fondo del modal
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen de la propiedad con bordes redondeados
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft:
                      Radius.circular(20), 
                  topRight: Radius.circular(20),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Image.network(
                    '${Config.imagen}${property.imageUrl}',
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Título de la propiedad
              Text(
                property.title ?? 'Sin título',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorTexto,
                ),
              ),
              const SizedBox(height: 10),

              // Descripción
              Text(
                property.description ?? 'Sin descripción disponible',
                style: TextStyle(
                  fontSize: 16,
                  color: colorTexto,
                ),
              ),
              const SizedBox(height: 10),

              // Dirección y otros detalles usando RichText para juntar los textos
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: colorTexto),
                  children: [
                    const TextSpan(
                      text: 'Dirección: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: property.address ?? 'No especificado',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: colorTexto),
                  children: [
                    const TextSpan(
                      text: 'Estado de la propiedad: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: property.statutsProperty ?? 'No especificado',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: colorTexto),
                  children: [
                    const TextSpan(
                      text: 'Tipo de propiedad: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: property.type ?? 'No especificado',
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Botón "Ver más"
              Center(
                child: ElevatedButton(
                  onPressed: () {
                      context.push('/detalle', extra: {
                        'id_propiedad': property.idProperty,
                      });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Ver más',
                    style: TextStyle(fontSize: 16, color: colorTextoButton),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _printVisibleRegion() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds bounds = await controller.getVisibleRegion();
    // Cargar propiedades dentro del área visible
    await _fetchProperties(bounds);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              await _printVisibleRegion(); // Imprimir las esquinas visibles al crear el mapa
            },
            onCameraIdle: () async {
              await _printVisibleRegion(); // Imprimir las esquinas visibles cuando el movimiento de la cámara termina
            },
            markers: _currentLocationMarker != null
                ? {..._propertyMarkers, _currentLocationMarker!}
                : _propertyMarkers,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            top: 40,
            right: 20,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              backgroundColor: primaryColor,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
