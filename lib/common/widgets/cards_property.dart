import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PropertyCard extends StatefulWidget {
  // Propiedades del widget
  final bool isFavorites;
  final int idPropiedad;
  final String title;
  final String type;
  final double price;
  final String status;
  final String direction;
  final String imageUrl;
  final int? EcoFriendly;
  final int? InteresSocial;
  // Método para copiar el widget con nuevas propiedades
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
    // Devuelve una nueva instancia del widget con las propiedades actualizadas
    return PropertyCard(
      idPropiedad: idPropiedad ?? this.idPropiedad,
      isFavorites: isFavorites ?? this.isFavorites,
      title: title ?? this.title,
      type: type ?? this.type,
      price: price ?? this.price,
      status: status ?? this.status,
      direction: direction ?? this.direction,
      imageUrl: imageUrl ?? this.imageUrl,
      EcoFriendly: EcoFriendly ?? this.EcoFriendly,
      InteresSocial: InteresSocial ?? this.InteresSocial,
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
    required this.EcoFriendly,
    required this.InteresSocial,
  }) : super(key: key);

  @override
  _PropertyCardState createState() => _PropertyCardState();
}
// Estado del widget
class _PropertyCardState extends State<PropertyCard> {
  late bool isFavorite;
  // Inicializa el estado del widget
  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorites;
  }
  // Construye el widget
  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.width * 0.6;
    String truncatedTitle = widget.title.length > 25
        ? '${widget.title.substring(0, 25)}...'
        : widget.title;
    String truncatedDirection = cleanAndTruncateDirection(widget.direction);
    // Devuelve un widget de tipo GestureDetector para detalles de la propiedad
    return GestureDetector(
      onTap: () {
        context.push('/detalle', extra: {'id_propiedad': widget.idPropiedad});
      }, 
      // Devuelve un widget de tipo Card con la información de la propiedad
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
              child: _buildImage(),
            ),
            // Gradiente sobre la imagen
            Container(
              height: containerHeight,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            // Estado de la propiedad
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
            // Información de la propiedad
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
            // Icono de Eco Friendly si es aplicable
            if (widget.EcoFriendly == 1)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.eco,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            // Icono de Interés Social si es aplicable
            if (widget.InteresSocial == 1)
              Positioned(
                top: 10,
                right: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.group,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  // Método para limpiar y truncar la dirección
  String cleanAndTruncateDirection(String direction) {
    String cleanedDirection =
        direction.length > 10 ? direction.substring(10) : direction;
    return cleanedDirection.length > 50
        ? '${cleanedDirection.substring(0, 50)}...'
        : cleanedDirection;
  }
  // Método para construir la imagen de la propiedad
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
  // Método para construir el icono por defecto
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
