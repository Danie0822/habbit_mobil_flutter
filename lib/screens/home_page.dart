import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/buildFilter.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_property.dart';
import 'package:habbit_mobil_flutter/common/widgets/filters.dart';
import 'package:habbit_mobil_flutter/data/controlers/properties.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'Tus preferencias';

  /// Lista de tarjetas de propiedades
  final List<PropertyCard> _propertyCards = [];
  // Lista completa de propiedades
  final List<PropertyCard> _allProperties = [];
  // Clave global para la lista animada
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // Indicador de carga
  bool _isLoading = false;
  // Controlador de búsqueda
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    //  Inicializa el controlador de búsqueda
    _searchController = TextEditingController();
    _searchController.addListener(_filterProperties);
    _loadPropertiesPreferences();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 45),
          _buildSearchBar(),
          _buildFilterOptions(),
          _buildPropertyList(),
        ],
      ),
    );
  }

  // Método para construir la barra de búsqueda
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 10),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Buscar por título...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // Método para construir las opciones de filtro
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

  // Método para construir una opción de filtro
  Widget _buildFilterOption(String filter, IconData icon) {
    return GestureDetector(
      onTap: () => _onFilterSelected(filter),
      child: buildFilter(filter, selectedFilter == filter, icon, context),
    );
  }

  // Método para construir la lista de propiedades
  Widget _buildPropertyList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.only(right: 24, left: 24, top: 5),
                itemCount: _propertyCards.length,
                itemBuilder: (context, index) {
                  return _buildPropertyItem(_propertyCards[index]);
                },
              ),
      ),
    );
  }

  // Método para construir un elemento de propiedad
  Widget _buildPropertyItem(PropertyCard propertyCard) {
    return Hero(
      tag: propertyCard.imageUrl,
      child: PropertyCard(
        EcoFriendly: propertyCard.EcoFriendly,
        InteresSocial: propertyCard.InteresSocial,
        idPropiedad: propertyCard.idPropiedad,
        title: propertyCard.title,
        type: propertyCard.type,
        direction: propertyCard.direction,
        price: propertyCard.price,
        status: propertyCard.status,
        imageUrl: propertyCard.imageUrl,
        isFavorites: propertyCard.isFavorites,
      ),
    );
  }

  // Método para mostrar la hoja inferior
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

  // Método para manejar la selección de filtro
  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    // Limpia la lista de propiedades
    _clearPropertyList();
    // Carga propiedades según el filtro seleccionado
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

  // Método para limpiar la lista de propiedades
  void _clearPropertyList() {
    for (int i = _propertyCards.length - 1; i >= 0; i--) {
      PropertyCard removedCard = _propertyCards.removeAt(i);
      _listKey.currentState?.removeItem(
        i,
        (context, animation) => _buildPropertyItem(removedCard),
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  // Método para cargar propiedades de preferencias
  Future<void> _loadPropertiesPreferences() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Obtener la lista de propiedades
      final properties = await PropertiesService().getProperties();
      // Limpiar la lista de propiedades
      _allProperties.clear();
      // Agregar las propiedades a la lista
      _allProperties.addAll(properties.map((property) {
        return PropertyCard(
            EcoFriendly: property.EcoFriendly,
            InteresSocial: property.InteresSocial,
            idPropiedad: property.idPropiedad ?? 0,
            title: property.title ?? 'Propiedad no encontrada',
            type: property.type ?? 'Error de datos',
            status: property.status ?? 'Error de datos',
            direction: property.direction ?? 'Error de datos',
            price: property.price ?? 0.0,
            imageUrl: property.imageUrl != null
                ? '${Config.imagen}${property.imageUrl}'
                : '',
            isFavorites: false);
      }).toList());
      // Filtra propiedades con base en el texto de búsqueda
      _filterProperties();
    } catch (e) {
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _filterProperties() {
    // Filtra propiedades con base en el texto de búsqueda
    final query = _searchController.text.toLowerCase();
    // Filtra propiedades con base en el texto de búsqueda
    final filteredProperties = _allProperties.where((property) {
      return property.title.toLowerCase().contains(query);
    }).toList();
    // Limpia la lista de propiedades
    _clearPropertyList();
    // Agrega las propiedades filtradas a la lista
    if (mounted) {
      setState(() {
        // Limpia la lista de propiedades
        _propertyCards.clear();
        // Agrega las propiedades filtradas a la lista
        _propertyCards.addAll(filteredProperties);
        // Agrega las propiedades a la lista animada
        for (int i = 0; i < filteredProperties.length; i++) {
          _listKey.currentState?.insertItem(i);
        }
      });
    }
  }

  // Método para gestionar favoritos
  Future<void> _toggleFavorite(int idPropiedad) async {
    try {
      // Agrega la propiedad a favoritos
      final response =
          await PropertiesService().addPropertyToFavorites(idPropiedad);

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
    }
  }

  Future<void> _loadPropertiesIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Obtener la lista de propiedades
      final properties = await PropertiesService().getPropertiesInm();
      // Limpiar la lista de propiedades
      _allProperties.clear();
      // Agregar las propiedades a la lista
      _allProperties.addAll(properties.map((property) {
        return PropertyCard(
          EcoFriendly: property.EcoFriendly,
          InteresSocial: property.InteresSocial,
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
        );
      }).toList());
      // Filtra propiedades con base en el texto de búsqueda
      _filterProperties();
    } catch (e) {
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Método para cargar proyectos
  Future<void> _loadPropertiesProyects() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Obtener la lista de propiedades
      final properties = await PropertiesService().getPropertiesProyects();
      // Limpiar la lista de propiedades
      _allProperties.clear();
      // Agregar las propiedades a la lista
      _allProperties.addAll(properties.map((property) {
        return PropertyCard(
          EcoFriendly: property.EcoFriendly,
          InteresSocial: property.InteresSocial,
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
        );
      }).toList());
      // Filtra propiedades con base en el texto de búsqueda
      _filterProperties();
    } catch (e) {
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Método para aplicar filtros
  Future<void> _onFilterApplied(int category, int zone, double min, double max) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Obtener propiedades filtradas
      final properties = await PropertiesService()
          .getPropertiesFilters(category, zone, min, max);
      // Mapear propiedades a tarjetas
      List<PropertyCard> newPropertyCards = properties.map((property) {
        return PropertyCard(
          EcoFriendly: property.EcoFriendly,
          InteresSocial: property.InteresSocial,
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
        );
      }).toList();
      // Limpiar la lista de propiedades
      _clearPropertyList();
      // Agregar propiedades filtradas a la lista
      setState(() {
        // Limpiar la lista de propiedades
        _propertyCards.addAll(newPropertyCards);
        // Agregar las propiedades a la lista animada
        for (int i = 0; i < newPropertyCards.length; i++) {
          _listKey.currentState?.insertItem(i);
        }
      });
    } catch (e) {
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
