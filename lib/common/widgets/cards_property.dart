import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PropertyCard extends StatefulWidget {
  // Propiedades del widget
  // Indica si la propiedad es favorita
  final bool isFavorites;
  // ID de la propiedad
  final int idPropiedad;
  // Título de la propiedad
  final String title;
  // Tipo de propiedad
  final String type;
  // Precio de la propiedad
  final double price;
  // Estado de la propiedad
  final String status;
  // Dirección de la propiedad
  final String direction;
  // URL de la imagen
  final String imageUrl;

  // Método copyWith que permite crear una copia del PropertyCard y modificar valores específicos
  PropertyCard copyWith({
    bool? isFavorites,
    int? idPropiedad,
    String? title,
    String? type,
    double? price,
    String? status,
    String? direction,
    String? imageUrl,
  }) {
    return PropertyCard(
      idPropiedad: idPropiedad ?? this.idPropiedad,
      isFavorites: isFavorites ?? this.isFavorites,
      title: title ?? this.title,
      type: type ?? this.type,
      price: price ?? this.price,
      status: status ?? this.status,
      direction: direction ?? this.direction,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  const PropertyCard({
    Key? key,
    required this.idPropiedad,
    required this.isFavorites,
    required this.title,
    required this.type,
    required this.price,
    required this.status,
    required this.direction,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _PropertyCardState createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  // Estado de favorito
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    // Inicializamos el estado de favorito con el valor inicial del widget
    isFavorite = widget.isFavorites;
  }

  @override
  Widget build(BuildContext context) {
    // Altura del contenedor
    double containerHeight = MediaQuery.of(context).size.width * 0.6;

    // Trunca el título si es muy largo
    String truncatedTitle = widget.title.length > 25
        ? '${widget.title.substring(0, 25)}...'
        : widget.title;

    // Trunca y limpia la dirección
    String truncatedDirection = cleanAndTruncateDirection(widget.direction);

    // Contenedor de la tarjeta
    return GestureDetector(
      onTap: () {
        context.push('/detalle', extra: {
          'id_propiedad': widget.idPropiedad,
        });
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 15),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        elevation: 5,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: containerHeight,
              child: _buildImage(), // Función que carga la imagen
            ),
            Container(
              height: containerHeight,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              top: containerHeight * 0.08,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  widget.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        truncatedTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          truncatedDirection,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        r"$" + widget.price.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
    );
  }

  // Función que limpia y trunca la dirección
  String cleanAndTruncateDirection(String direction) {
    String cleanedDirection = direction.length > 10 ? direction.substring(10) : direction;
    return cleanedDirection.length > 50
        ? '${cleanedDirection.substring(0, 50)}...'
        : cleanedDirection;
  }

  // Función que carga la imagen
  Widget _buildImage() {
    try {
      if (widget.imageUrl.isNotEmpty) {
        return Image.network(
          widget.imageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('Error loading image: $error');
            return _defaultIcon();
          },
        );
      }
    } catch (e) {
      print('Exception loading image: $e');
    }
    return _defaultIcon();
  }

  // Función que muestra un icono por defecto
  Widget _defaultIcon() {
    return Container(
      color: Colors.grey,
      child: const Icon(
        Icons.account_circle,
        size: 75,
        color: Colors.white,
      ),
    );
  }
}
