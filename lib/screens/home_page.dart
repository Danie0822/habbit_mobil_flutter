import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/buildFilter.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_property.dart';
import 'package:habbit_mobil_flutter/common/widgets/filters.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_search.dart';
import 'package:habbit_mobil_flutter/data/controlers/properties.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'Tus preferencias';
  final List<PropertyCard> _propertyCards = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _isLoading = false;

  

  @override
  void initState() {
    super.initState();
    _loadPropertiesPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          _buildFilterOptions(),
          _buildPropertyList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 10),
      child: TextFieldSearch(),
    );
  }

  Widget _buildFilterOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SizedBox(
              height: 40,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterOption('Tus preferencias', Icons.favorite),
                  _buildFilterOption('Inmuebles', Icons.home),
                  _buildFilterOption('Proyectos', Icons.work)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _showBottomSheet,
            child: const Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                'Filtros',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String filter, IconData icon) {
    return GestureDetector(
      onTap: () => _onFilterSelected(filter),
      child: buildFilter(filter, selectedFilter == filter, icon, context),
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
                initialItemCount: _propertyCards.length,
                padding: const EdgeInsets.only(right: 24, left: 24, top: 5),
                itemBuilder: (context, index, animation) {
                  return _buildPropertyItem(_propertyCards[index], animation);
                },
              ),
      ),
    );
  }

  Widget _buildPropertyItem(
      PropertyCard propertyCard, Animation<double> animation) {
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
          isFavorites: propertyCard.isFavorites,
          onFavorite: _toggleFavorite, // Aquí se usa el método
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Filter(
            onApplyFilters: (int category, int zone, double min, double max) {
              _onFilterApplied(category, zone, min, max);
            },
          ),
        );
      },
    );
  }

  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });

    _clearPropertyList();

    switch (filter) {
      case 'Tus preferencias':
        _loadPropertiesPreferences();
        break;
      case 'Inmuebles':
        _loadPropertiesIn();
        break;
      case 'Proyectos':
        _loadPropertiesProyects();
        break;
    }
  }

  void _clearPropertyList() {
    for (int i = _propertyCards.length - 1; i >= 0; i--) {
      PropertyCard removedCard = _propertyCards.removeAt(i);
      _listKey.currentState?.removeItem(
        i,
        (context, animation) => _buildPropertyItem(removedCard, animation),
        duration: const Duration(milliseconds: 300),
      );
    }
  }

 Future<void> _loadPropertiesPreferences() async {
  setState(() {
    _isLoading = true;
  });

  try {
    final properties = await PropertiesService().getProperties();

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
        isFavorites: property.isFavorite ?? false, // Aquí cargamos el estado de favorito
        onFavorite: _toggleFavorite,
      );
    }).toList();

    if (mounted) {
      setState(() {
        _propertyCards.clear();
        _propertyCards.addAll(newPropertyCards);

        for (int i = 0; i < newPropertyCards.length; i++) {
          _listKey.currentState?.insertItem(i);
        }
      });
    }
  } catch (e) {
    print('Error cargando propiedades: $e');
  } finally {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }
}


  Future<void> _toggleFavorite(int idPropiedad) async {
    try {
      // Llama al método del controlador para agregar/quitar de favoritos
      final response = await PropertiesService().addPropertyToFavorites(idPropiedad);

      if (response == 200) {
        setState(() {
          for (var i = 0; i < _propertyCards.length; i++) {
            if (_propertyCards[i].idPropiedad == idPropiedad) {
              _propertyCards[i] = _propertyCards[i].copyWith(
                isFavorites: !_propertyCards[i].isFavorites,
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

  Future<void> _loadPropertiesIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final properties = await PropertiesService().getPropertiesInm();

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
          isFavorites: false,
          onFavorite: _toggleFavorite,
        );
      }).toList();

      if (mounted) {
        setState(() {
          _propertyCards.clear();
          _propertyCards.addAll(newPropertyCards);

          for (int i = 0; i < newPropertyCards.length; i++) {
            _listKey.currentState?.insertItem(i);
          }
        });
      }
    } catch (e) {
      print('Error cargando inmuebles: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadPropertiesProyects() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final properties = await PropertiesService().getPropertiesProyects();

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
          isFavorites: false,
          onFavorite: _toggleFavorite,
        );
      }).toList();

      if (mounted) {
        setState(() {
          _propertyCards.clear();
          _propertyCards.addAll(newPropertyCards);

          for (int i = 0; i < newPropertyCards.length; i++) {
            _listKey.currentState?.insertItem(i);
          }
        });
      }
    } catch (e) {
      print('Error cargando proyectos: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onFilterApplied(
      int category, int zone, double minPrice, double maxPrice) {
    setState(() {
      selectedFilter = '';
    });

    _clearPropertyList();
    _loadPropertiesFiltered(category, zone, minPrice, maxPrice);
  }

  Future<void> _loadPropertiesFiltered(
      int category, int zone, double minPrice, double maxPrice) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final properties = await PropertiesService().getPropertiesFilters(
          category, zone, minPrice, maxPrice);

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
          isFavorites: false,
          onFavorite: _toggleFavorite,
        );
      }).toList();

      if (mounted) {
        setState(() {
          _propertyCards.clear();
          _propertyCards.addAll(newPropertyCards);

          for (int i = 0; i < newPropertyCards.length; i++) {
            _listKey.currentState?.insertItem(i);
          }
        });
      }
    } catch (e) {
      print('Error aplicando filtros: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
