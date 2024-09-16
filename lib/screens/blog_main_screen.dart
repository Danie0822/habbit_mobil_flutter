import 'dart:ui'; // Necesario para usar BackdropFilter
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_blogs.dart';
import 'package:habbit_mobil_flutter/data/controlers/blogs_main.dart';
import 'package:habbit_mobil_flutter/data/models/blogs_main.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class blogMain extends StatefulWidget {
  const blogMain({Key? key}) : super(key: key);

  @override
  State<blogMain> createState() => _blogMainState();
}

class _blogMainState extends State<blogMain> {
  List<BlogsResponse> requestsData = [];
  List<BlogsResponse> filteredRequests = [];
  final CarouselController _carouselController = CarouselController();
  int _current = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    try {
      setState(() {
        isLoading = true;
      });
      final loadedRequests = await BlogsService().getBlogs();
      setState(() {
        requestsData = loadedRequests;
        filteredRequests = requestsData;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            if (isLoading || requestsData.isEmpty)
              // Mostrar un indicador de carga mientras se obtienen los datos
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              Stack(
                children: [
                  // Imagen de fondo con desenfoque
                  Positioned.fill(
                    child: Image.network(
                      '${Config.imagen}${requestsData[_current].imageUrl?.trim()}', // Elimina espacios al final
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text('Error al cargar la imagen'),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  // Filtro de desenfoque
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0), // Ajusta la opacidad
                      ),
                    ),
                  ),
                  // Gradiente en la parte inferior
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.grey.shade50.withOpacity(1),
                            Colors.grey.shade50.withOpacity(1),
                            Colors.grey.shade50.withOpacity(0.8),
                            Colors.grey.shade50.withOpacity(0.7),
                            Colors.grey.shade50.withOpacity(0.6),
                            Colors.grey.shade50.withOpacity(0.4),
                            Colors.grey.shade50.withOpacity(0.3),
                            Colors.grey.shade50.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Título Blogs
                  Positioned(
                    top: 40,
                    left: 30,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Blogs',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Contenido del carrusel
                  Positioned(
                    bottom: 50,
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider.builder(
                      itemCount: requestsData.length,
                      itemBuilder: (context, index, realIdx) {
                        return BlogCard(
                          dataBlogs: requestsData[index], // Pasar un solo blog
                        );
                      },
                      options: CarouselOptions(
                        height: 565.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.80,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
