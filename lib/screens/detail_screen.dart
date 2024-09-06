import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_property.dart';
import 'package:habbit_mobil_flutter/data/models/image.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/data/controlers/properties_detail.dart';
import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final int idPropiedad;

  const PropertyDetailsScreen({super.key, required this.idPropiedad});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  bool isFavorite = false;
  List<PropertiesResponse>? _propertyDetails;
  List<ImageModel>? _propertyImages;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadPropertyData();
  }

  Future<void> _loadPropertyData() async {
    try {
      // Cargar detalles de la propiedad e imágenes en paralelo
      final propertyDetailsFuture = await PropertiesDetailService().getPropertiesDetails(widget.idPropiedad);
      final propertyImagesFuture =  await PropertiesDetailService().getPropertiesDetailsImage(widget.idPropiedad);

      final propertyDetails = await propertyDetailsFuture;
      final propertyImages = await propertyImagesFuture;

      setState(() {
        _propertyDetails = propertyDetails;
        _propertyImages = propertyImages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      print('Error cargando los datos: $e');
    }
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color colorTexto = ThemeUtils.getColorBasedOnBrightness(
        context, secondaryColor, lightTextColor);
    double horizontalPadding = size.width * 0.06;
    double verticalPadding = size.height * 0.02;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? const Center(child: Text('Error al cargar los datos'))
              : _propertyDetails == null || _propertyDetails!.isEmpty
                  ? const Center(child: Text('Propiedad no encontrada'))
                  : _buildPropertyDetails(context, size, colorTexto, horizontalPadding, verticalPadding),
    );
  }

  Widget _buildPropertyDetails(BuildContext context, Size size, Color colorTexto, double horizontalPadding, double verticalPadding) {
    final property = _propertyDetails![0]; // Asume que siempre habrá al menos un detalle de propiedad

    return Stack(
      children: [
        Hero(
          tag: property.imageUrl ?? '',
          child: Container(
            height: size.height * 0.35,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: property.imageUrl != null && property.imageUrl!.isNotEmpty
                  ? Image.network(
                      '${Config.imagen}${property.imageUrl}',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _defaultIcon();
                      },
                    )
                  : _defaultIcon(),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.near_me,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        // Acción de navegación
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding / 2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  width: size.width * 0.2,
                  padding: EdgeInsets.symmetric(vertical: verticalPadding / 5),
                  child: Center(
                    child: Text(
                      property.status ?? 'Sin estado',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        property.title ?? 'Propiedad sin nombre',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: toggleFavorite,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFavorite
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.redAccent
                              : Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    top: verticalPadding / 2,
                    bottom: verticalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          property.direction ?? 'Sin dirección',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 22, 20, 20),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.height * 0.65,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Información del propietario
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property.admin ?? 'Sin administrador',
                              style: AppStyles.headline6(context, colorTexto),
                            ),
                            SizedBox(height: verticalPadding / 4),
                            Text(
                              "Propietario",
                              style: AppStyles.subtitle1(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: verticalPadding),
                    Text(
                      "Descripción",
                      style: AppStyles.headline6(context, colorTexto),
                    ),
                    SizedBox(height: verticalPadding / 2),
                    Text(
                      property.description ?? 'Sin descripción',
                      style: AppStyles.headlinee6(context, colorTexto),
                    ),
                    SizedBox(height: verticalPadding),
                    // Características de la propiedad
                    Text(
                      "Características",
                      style: AppStyles.headline6(context, colorTexto),
                    ),
                    SizedBox(height: verticalPadding / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (property.rooms != null && property.rooms! > 0)
                          buildFeature(Icons.hotel, "${property.rooms}"),
                        if (property.bathroms != null && property.bathroms! > 0)
                          buildFeature(Icons.bathtub, "${property.bathroms}"),
                        if (property.parkings != null && property.parkings! > 0)
                          buildFeature(Icons.garage, "${property.parkings}"),
                        // Agregando el precio a las características
                        buildFeature(Icons.attach_money, "\$${property.price ?? 0.0}"),
                      ],
                    ),
                    SizedBox(height: verticalPadding),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFeature(IconData icon, String value) {
    return Column(
      children: [
        Icon(icon, size: 30),
        SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _defaultIcon() {
    return Container(
      color: Colors.grey,
      child: const Icon(
        Icons.error,
        color: Colors.white,
        size: 60,
      ),
    );
  }
}
