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
        requestsData.shuffle(); // Mezclar la lista
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              customBorder: CircleBorder(),
              onTap: () {
                context.pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.6),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.4),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Blogs',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
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
                        return Center(
                          child: Text(
                            'Error al cargar la imagen',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
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
                            color: isDarkMode ? Colors.white : Colors.black,
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
                        color: isDarkMode
                            ? Colors.black.withOpacity(0.3)
                            : Colors.black.withOpacity(0),
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
                          colors: isDarkMode
                              ? [
                                  Colors.black.withOpacity(1),
                                  Colors.black.withOpacity(0.8),
                                  Colors.black.withOpacity(0.6),
                                  Colors.black.withOpacity(0.4),
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.2),
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.0),
                                ]
                              : [
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
                  // Contenido del carrusel
                  Positioned(
                    bottom: 50,
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider.builder(
                      itemCount: requestsData.length,
                      itemBuilder: (context, index, realIdx) {
                        return BlogCard(
                          dataBlogs: requestsData[index],
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
