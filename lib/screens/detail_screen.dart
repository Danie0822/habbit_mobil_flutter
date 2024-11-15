import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/data/controlers/properties.dart';
import 'package:habbit_mobil_flutter/data/models/image.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/data/controlers/properties_detail.dart';
import 'package:habbit_mobil_flutter/data/controlers/message.dart';
import 'package:habbit_mobil_flutter/data/models/properties.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final int idPropiedad;

  const PropertyDetailsScreen({super.key, required this.idPropiedad});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  // Indicador de favorito
  int isFavorite = 0;
  // Detalles de la propiedad
  List<PropertiesResponse>? _propertyDetails;
  // Imágenes de la propiedad
  List<ImageModel>? _propertyImages;
  // Indicador de carga
  bool _isLoading = true;
  // Indicador de error
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Cargar los datos de la propiedad
    _loadPropertyData();
  }

  Future<void> _loadPropertyData() async {
    try {
      // Cargar detalles de la propiedad e imágenes en paralelo
      final propertyDetailsFuture = await PropertiesDetailService()
          .getPropertiesDetails(widget.idPropiedad);
      //Obtener las imagenes de la propiedad
      final propertyImagesFuture = await PropertiesDetailService()
          .getPropertiesDetailsImage(widget.idPropiedad);
      // Esperar a que ambas operaciones finalicen
      final propertyDetails = propertyDetailsFuture;
      //Esperar a que ambas operaciones finalicen
      final propertyImages = propertyImagesFuture;

      setState(() {
        // Asignar los datos a las variables
        _propertyDetails = propertyDetails;
        //Asignar las imagenes a las variables
        _propertyImages = propertyImages;
        // Asignar el indicador de favorito
        isFavorite = _propertyDetails![0].isFavorite;
        // Restablecer los indicadores de carga y error
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  //Indicador de creacion de chat
  bool _isCreatingChat = false;

  Future<void> _handleCreateChat() async {
    // Evita que se vuelva a presionar el botón mientras se está creando el chat
    if (_isCreatingChat) return;

    setState(() {
      // Indica que se está creando un chat
      _isCreatingChat = true;
    });

    try {
      // Verifica que existan detalles de la propiedad
      if (_propertyDetails != null && _propertyDetails!.isNotEmpty) {
        // Obtiene los detalles de la propiedad
        final property = _propertyDetails![0];
        // Crea un chat con el administrador de la propiedad
        final response = await MessageService().crearChat(widget.idPropiedad);
        // Obtiene el id de la conversación
        final idConversacion = response.idConversacion;
        // Verifica que el administrador de la propiedad y el id de la conversación no sean nulos
        if (property.admin != null && idConversacion != null) {
          context.push('/chat', extra: {
            'idConversacion': idConversacion,
            'nameUser': property.admin,
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Inténtalo de nuevo.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocurrió un error, intente más tarde.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocurrió un error, intente más tarde.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        // Restablece el estado cuando la operación termine
        _isCreatingChat = false;
      });
    }
  }

  void toggleFavorite() async {
    try {
      // Llama al método del controlador para agregar/quitar de favoritos
      final response =
          await PropertiesService().addPropertyToFavorites(widget.idPropiedad);
      if (response) {
        setState(() {
          // Cambia el indicador de favorito
          isFavorite = isFavorite == 0 ? 1 : 0;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocurrió un error, intente más tarde.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
    }
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
                  : _buildPropertyDetails(context, size, colorTexto,
                      horizontalPadding, verticalPadding),
    );
  }

  Widget _buildPropertyDetails(BuildContext context, Size size,
      Color colorTexto, double horizontalPadding, double verticalPadding) {
    // Asume que siempre habrá al menos un detalle de propiedad
    final property = _propertyDetails![
        0];
    // Limpia y trunca la dirección
    String truncatedDirection =
        cleanAndTruncateDirection(property.direction ?? 'No disponible');

    // Define el color basado en el tema (brillo de la pantalla)
    final Color colorTextoTitulo =
        Theme.of(context).brightness == Brightness.light
            ? const Color(0xFF06065E) // Color para modo claro
            : ThemeUtils.getColorBasedOnBrightness(
                context, Colors.white, Colors.grey);

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
                    vertical: verticalPadding * 3),
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
                        fontSize: 15,
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
                          color: (isFavorite == 1)
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          (isFavorite == 1)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: (isFavorite == 1)
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
                          truncatedDirection,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 236, 227, 227),
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
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Alinea verticalmente el contenido al centro
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.admin ?? 'Sin administrador',
                                style: AppStyles.headline6(context, colorTexto),
                                maxLines:
                                    2, // Establecemos un límite máximo de líneas para evitar que el texto crezca mucho
                                overflow: TextOverflow
                                    .visible, // Permite el salto de línea sin cortar el texto
                              ),
                              SizedBox(height: verticalPadding / 4),
                              Text(
                                "Propietario",
                                style: AppStyles.subtitle1(context),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          iconSize: 36, // Tamaño del ícono más grande
                          icon: Icon(Icons.chat, color: colorTextoTitulo),
                          onPressed: _handleCreateChat,
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
                          buildFeature(
                              Icons.directions_car, "${property.parkings}"),
                        if (property.price != null && property.price! > 0)
                          buildFeature(
                              Icons.monetization_on, "${property.price}"),
                      ],
                    ),
                    SizedBox(height: verticalPadding * 1.5),
                    // Fotos de la propiedad
                    const Text("Fotos",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: verticalPadding / 2),
                    _buildPhotosList(size, verticalPadding),
                    SizedBox(height: verticalPadding / 2),
                    SizedBox(
                      height: size.height * 0.2, // Definir altura de las fotos
                      child: _propertyImages == null || _propertyImages!.isEmpty
                          ? const Center(
                              child: Text('No hay fotos disponibles'))
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: _propertyImages!.length,
                              itemBuilder: (context, index) {
                                return null;
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
  // Construye la lista de fotos de la propiedad
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
  // Limpia y trunca la dirección
  String cleanAndTruncateDirection(String direction) {
    String cleanedDirection =
        direction.length > 10 ? direction.substring(10) : direction;
    return cleanedDirection.length > 40
        ? '${cleanedDirection.substring(0, 40)}...'
        : cleanedDirection;
  }
  // Construye un widget de foto
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
// Construye un widget de característica
Widget buildFeature(IconData icon, String label) {
  return Column(
    children: [
      Icon(icon, size: 32, color: Colors.grey),
      SizedBox(height: 4),
      Text(label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ],
  );
}
// Construye un ícono predeterminado
Widget _defaultIcon() {
  return const Icon(
    Icons.image_not_supported_outlined,
    size: 80,
    color: Colors.grey,
  );
}
