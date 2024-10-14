import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/rating.dart';
import 'package:habbit_mobil_flutter/data/models/blogs_main.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class BlogDetail extends StatefulWidget {
  final BlogsResponse blogsResponse;
  const BlogDetail({Key? key, required this.blogsResponse}) : super(key: key);

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  int _userRating = 0; // Valoración seleccionada por el usuario

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    // Obtener los datos del blog
    final _data = widget.blogsResponse;
    // Verificar si el modo oscuro está activado
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: _buildAppBar(size, isDarkMode, _data.idBlogs ?? 0),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageBackground(size, _data.imageUrl, isDarkMode),
            _buildContent(size, _data, isDarkMode),
          ],
        ),
      ),
    );
  }

  // Método para construir el AppBar con una flecha de retroceso y una estrella
  AppBar _buildAppBar(Size size, bool isDarkMode, int id) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: isDarkMode ? Colors.white30 : Colors.black26, // Efecto de splash
            customBorder: const CircleBorder(), // Forma circular
            onTap: () {
              Navigator.pop(context); // Regresa a la pantalla anterior
            },
            child: Container(
              width: size.width * 0.12, // Forma circular
              height: size.width * 0.12,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.6),
                shape: BoxShape.circle, // Botón circular
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4), // Sombra debajo
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back, // Icono de flecha
                color: isDarkMode ? Colors.white : Colors.black,
                size: size.width * 0.06, // Tamaño de la flecha
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: isDarkMode ? Colors.white30 : Colors.black26, // Efecto de splash
              customBorder: const CircleBorder(), // Forma circular
              onTap: () {
                // Mostrar el modal de valoración al hacer clic
                _openRatingModal(context, id);
              },
              child: Container(
                width: size.width * 0.12, // Forma circular
                height: size.width * 0.12,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.6),
                  shape: BoxShape.circle, // Botón circular
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4), // Sombra debajo
                    ),
                  ],
                ),
                child: Icon(
                  Icons.star, // Icono de estrella
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: size.width * 0.06, // Tamaño de la estrella
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Método para abrir el modal de valoración
  void _openRatingModal(BuildContext context, int id) async {
    final selectedRating = await showDialog<int>(
      context: context,
      builder: (context) => RatingModal(idSolicitud: id,), // Abre el modal
    );

    if (selectedRating != null) {
      setState(() {
        _userRating = selectedRating; // Guardar la valoración seleccionada
      });
      print('Valoración seleccionada: $_userRating');
    }
  }

  // Método para construir el fondo de imagen
  Widget _buildImageBackground(Size size, String? imageUrl, bool isDarkMode) {
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.5,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.network(
              '${Config.imagen}${imageUrl}',
              width: size.width,
              height: size.height * 0.5,
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
            ),
          ),
        ),
        Container(
          height: size.height * 0.5,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(1.0),
                    ]
                  : [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.grey.shade50.withOpacity(0.1),
                      Colors.grey.shade50.withOpacity(0.3),
                      Colors.grey.shade50.withOpacity(0.5),
                      Colors.grey.shade50.withOpacity(0.7),
                      Colors.grey.shade50.withOpacity(1.0),
                    ],
            ),
          ),
        ),
      ],
    );
  }

  // Método para construir el contenido del detalle del blog
  Widget _buildContent(Size size, BlogsResponse _data, bool isDarkMode) {
    return Container(
      width: size.width,
      color: isDarkMode ? Colors.black : Colors.grey.shade50,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _data.title ?? 'No se encontró título',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.width * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: size.width * 0.06),
              SizedBox(width: size.width * 0.02),
              Text(
                _data.rating.toString(),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: size.width * 0.05,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            _data.description ?? 'No se encontró descripción',
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black,
              fontSize: size.width * 0.045,
            ),
          ),
        ],
      ),
    );
  }
}
