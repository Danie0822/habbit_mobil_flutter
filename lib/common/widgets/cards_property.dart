import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/data.dart';

class PropertyCard extends StatefulWidget {
  final Property property;
  final int index;

  const PropertyCard({Key? key, required this.property, required this.index})
      : super(key: key);

  @override
  _PropertyCardState createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  late final Property property;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    property = widget.property;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/detalle', extra: property);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 15),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        elevation: 5,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: 800.ms,
              curve: Curves.easeInOut,
              height: 210,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.property.frontImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 210,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
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
              top: 16,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  widget.property.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(duration: 800.ms).slideX(
                    begin: 1.0,
                    end: 0.0,
                    duration: 800.ms,
                    curve: Curves.easeInOut),
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
                        widget.property.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animate().fadeIn(duration: 800.ms).slideX(
                          begin: -1.0,
                          end: 0.0,
                          duration: 800.ms,
                          curve: Curves.easeInOut),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: toggleFavorite,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.white
                                    : Colors.grey[600],
                                size: 24,
                              ),
                            ),
                          )
                        ],
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
                          widget.property.location,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        r"$" + widget.property.price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ).animate().fadeIn(duration: 800.ms).slideY(
                  begin: 1.0,
                  end: 0.0,
                  duration: 800.ms,
                  curve: Curves.easeInOut),
            ),
          ],
        ),
      ),
    );
  }
}
