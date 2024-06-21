import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_property.dart';
import 'package:habbit_mobil_flutter/common/widgets/search_input.dart';
import 'package:habbit_mobil_flutter/data/data.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

// Definición del estado de la pantalla de "Guardados" (LikeScreen)
class LikeScreen extends StatefulWidget {
  LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

// Clase de estado para manejar la lógica y el estado de LikeScreen
class _LikeScreenState extends State<LikeScreen> with SingleTickerProviderStateMixin {
  // Lista de propiedades obtenidas de una fuente de datos
  List<Property> properties = getPropertyList();
  bool _isSearchVisible = false; // Indicador para mostrar/ocultar la barra de búsqueda
  late AnimationController _controller; // Controlador para las animaciones
  late Animation<Offset> _offsetAnimation; // Animación para la transición de la barra de búsqueda

  @override
  void initState() {
    super.initState();
    // Inicialización del controlador de animaciones
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    // Definición de la animación para la barra de búsqueda
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // La animación empieza fuera de la pantalla (arriba)
      end: const Offset(0, 0), // La animación termina en su posición original
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Curva de animación
    ));
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberar recursos del controlador cuando ya no se necesite
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtener color de fondo basado en el tema (claro u oscuro)
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor);

    return Scaffold(
      backgroundColor: colorBackGroundMessage, // Color de fondo de la pantalla
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(), // Construir el encabezado de la pantalla
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: containerMain,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      _buildPropertyList(), // Construir la lista de propiedades
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir el encabezado de la pantalla
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Guardados',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: whiteColor,
                ),
              ),
              // Botón para mostrar/ocultar la barra de búsqueda
              IconButton(
                onPressed: _toggleSearch,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: child.key == ValueKey('search') ? animation : Tween<double>(begin: 1, end: 0.75).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Icon(
                    _isSearchVisible ? Icons.close : Icons.search,
                    key: ValueKey(_isSearchVisible ? 'close' : 'search'),
                    color: whiteColor,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
          if (_isSearchVisible)
            // Animación para la barra de búsqueda
            SlideTransition(
              position: _offsetAnimation,
              child: const SearchInput(),
            ),
        ],
      ),
    );
  }

  // Método para construir la lista de propiedades
  Widget _buildPropertyList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: ListView.builder(
          padding: const EdgeInsets.only(right: 24, left: 24, top: 5),
          itemCount: properties.length,
          itemBuilder: (context, index) {
            return Hero(
              tag: properties[index].frontImage,
              child: PropertyCard(property: properties[index], index: index),
            );
          },
        ),
      ),
    );
  }

  // Método para alternar la visibilidad de la barra de búsqueda
  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (_isSearchVisible) {
        _controller.forward(); // Iniciar animación de aparición
      } else {
        _controller.reverse(); // Iniciar animación de desaparición
      }
    });
  }

  void _onPropertyTapped(Property property) {
    // Lógica para manejar cuando se toca una propiedad (vacío por ahora)
  }
}
