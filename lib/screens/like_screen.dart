import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_property.dart';
import 'package:habbit_mobil_flutter/common/widgets/search_input.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/data/controlers/properties.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class LikeScreen extends StatefulWidget {
  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> with SingleTickerProviderStateMixin {
  bool _isSearchVisible = false; // Indicador de visibilidad de la barra de búsqueda
  List<PropertyCard> _favoritePropertyCards = []; // Lista de tarjetas de propiedades favoritas
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _isLoading = false; // Indicador de estado de carga
  late AnimationController _controller; 
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1), 
      end: const Offset(0, 0), 
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, 
    ));
    _loadFavoriteProperties(); // Cargar propiedades favoritas al iniciar
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor);

    return Scaffold(
      backgroundColor: colorBackGroundMessage, 
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
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
                      _buildPropertyList(), 
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
            SlideTransition(
              position: _offsetAnimation,
              child: const SearchInput(),
            ),
        ],
      ),
    );
  }

  Widget _buildPropertyList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : AnimatedList(
                key: _listKey,
                initialItemCount: _favoritePropertyCards.length,
                padding: const EdgeInsets.only(right: 24, left: 24, top: 5),
                itemBuilder: (context, index, animation) {
                  return _buildPropertyItem(_favoritePropertyCards[index], animation);
                },
              ),
      ),
    );
  }

  Widget _buildPropertyItem(PropertyCard propertyCard, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Hero(
        tag: propertyCard.imageUrl,
        child: PropertyCard(
          idPropiedad: propertyCard.idPropiedad,
          title: propertyCard.title,
          type: propertyCard.type,
          direction: propertyCard.direction,
          price: propertyCard.price,
          status: propertyCard.status,
          imageUrl: propertyCard.imageUrl,
          isFavorites: true
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(int idPropiedad) async {
    try {
      // Llama al método del controlador para agregar/quitar de favoritos
      final response = await PropertiesService().addPropertyToFavorites(idPropiedad);

      if (response == 200) {
        setState(() {
          for (var i = 0; i < _favoritePropertyCards.length; i++) {
            if (_favoritePropertyCards[i].idPropiedad == idPropiedad) {
              _favoritePropertyCards[i] = _favoritePropertyCards[i].copyWith(
                isFavorites: !_favoritePropertyCards[i].isFavorites,
              );
              break;
            }
          }
        });
      }
    } catch (e) {
      print('Error gestionando favoritos: $e');
    }
  }

  Future<void> _loadFavoriteProperties() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Llamar al servicio para obtener propiedades favoritas
      final properties = await PropertiesService().getPropertiesFavorites();

      List<PropertyCard> newPropertyCards = properties.map((property) {
        return PropertyCard(
          idPropiedad: property.idPropiedad ?? 0,
          title: property.title ?? 'Propiedad no encontrada',
          type: property.type ?? 'Error de datos',
          status: property.status ?? 'Error de datos',
          direction: property.direction ?? 'Error de datos',
          price: property.price ?? 0.0,
          imageUrl: property.imageUrl != null
              ? '${Config.imagen}${property.imageUrl}'
              : '',
          isFavorites: true,
        );
      }).toList();

      setState(() {
        _favoritePropertyCards.clear();
        _favoritePropertyCards.addAll(newPropertyCards);

        for (int i = 0; i < newPropertyCards.length; i++) {
          _listKey.currentState?.insertItem(i);
        }
      });
    } catch (e) {
      print('Error cargando propiedades favoritas: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (_isSearchVisible) {
        _controller.forward(); 
      } else {
        _controller.reverse(); 
      }
    });
  }
}
