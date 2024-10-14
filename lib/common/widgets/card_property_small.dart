import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class PropertyCardSmall extends StatefulWidget {
  final bool isFavorites;
  final int idPropiedad;
  final String title;
  final String type;
  final double price;
  final String status;
  final String imageUrl;

  const PropertyCardSmall({
    Key? key,
    required this.idPropiedad,
    required this.isFavorites,
    required this.title,
    required this.type,
    required this.price,
    required this.status,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _PropertyCardSmallState createState() => _PropertyCardSmallState();
}

class _PropertyCardSmallState extends State<PropertyCardSmall> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorites;
  }

  @override
  Widget build(BuildContext context) {
    // Ancho de la tarjeta (un tercio del ancho total de la pantalla)
    double cardWidth = MediaQuery.of(context).size.width / 3;
    double imageHeight = cardWidth * 0.9;
    // Trunca el título si es muy largo y asegura que sea responsivo
    String truncatedTitle = widget.title.length > 16
        ? '${widget.title.substring(0, 16)}...'
        : widget.title;

    return GestureDetector(
      onTap: () {
        context.push('/detalle', extra: {
          'id_propiedad': widget.idPropiedad,
        });
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen con ancho completo y ajustada al contenedor
            SizedBox(
              width: cardWidth,
              height: imageHeight,
              child: _buildImage(),
            ),
            // Título y Precio con diseño responsivo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truncatedTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2), // Ajustar la altura debajo del título
                  Text(
                    r"$" + widget.price.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 2), // Espacio reducido debajo del precio
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    try {
      if (widget.imageUrl.isNotEmpty) {
        return Image.network(
          '${Config.imagen}${widget.imageUrl}',
          width: double.infinity, // Asegura que ocupe todo el ancho
          height: double.infinity, // Asegura que ocupe todo el alto disponible
          fit: BoxFit.cover, // La imagen cubre el contenedor sin dejar espacio en blanco
          errorBuilder: (context, error, stackTrace) {
            return _defaultIcon();
          },
        );
      }
    } catch (e) {
      return _defaultIcon();
    }
    return _defaultIcon();
  }

  Widget _defaultIcon() {
    return Container(
      width: double.infinity, // Asegura que ocupe todo el ancho
      height: double.infinity, // Asegura que ocupe todo el alto
      color: Colors.grey,
      child: const Icon(
        Icons.account_circle,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}
