import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/data/models/image.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/data/controlers/properties_detail.dart';
import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/common/widgets/foto_widget.dart';
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
                          buildFeature(Icons.directions_car, "${property.parkings}"),
                      ],
                    ),
                    SizedBox(height: verticalPadding * 1.5),
                    // Fotos de la propiedad
                     const Text("Fotos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: verticalPadding / 2),
                    _buildPhotosList(size, verticalPadding),
                    SizedBox(height: verticalPadding / 2),
                    SizedBox(
                      height: size.height * 0.2, // Definir altura de las fotos
                      child: _propertyImages == null || _propertyImages!.isEmpty
                          ? const Center(child: Text('No hay fotos disponibles'))
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: _propertyImages!.length,
                              itemBuilder: (context, index) {
                                final image = _propertyImages![index];
                                
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildPhotosList(Size size, double verticalPadding) {
  return SizedBox(
    height: size.height * 0.2, // Altura de las fotos
    child: _propertyImages == null || _propertyImages!.isEmpty
        ? const Center(child: Text('No hay fotos disponibles'))
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: _propertyImages!.map((image) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _buildPhoto(context, '${Config.imagen}${image.url}'),
                );
              }).toList(),
            ),
          ),
  );
}
 

  Widget _buildPhoto(BuildContext context, String url) {
    return GestureDetector(
      onTap: () {
        context.push("/PhotoDetailScreen", extra: url);
      },
      child: Hero(
        tag: url,
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Ver',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  Widget buildFeature(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.grey),
        SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _defaultIcon() {
    return const Icon(
      Icons.image_not_supported_outlined,
      size: 80,
      color: Colors.grey,
    );
  }

  