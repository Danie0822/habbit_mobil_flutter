import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
  // Filtro seleccionado
  String selectedFilter = 'Inmuebles';

  // Lista de tarjetas de propiedades
  final List<PropertyCard> _propertyCards = [];

  // Clave para la AnimatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Estado de carga
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProperties(); // Cargar propiedades al iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(), // Barra de búsqueda
          _buildFilterOptions(), // Opciones de filtro
          _buildPropertyList(), // Lista de propiedades
        ],
      ),
    );
  }

  // Construye la barra de búsqueda
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 10),
      child: TextFieldSearch(),
    );
  }

  // Construye las opciones de filtro
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
                  _buildFilterOption('Inmuebles', Icons.home),
                  _buildFilterOption('Proyectos', Icons.work),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _showBottomSheet, // Muestra el modal de filtros
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

  // Construye una opción de filtro
  Widget _buildFilterOption(String filter, IconData icon) {
    return GestureDetector(
      onTap: () => _onFilterSelected(filter), // Maneja la selección del filtro
      child: buildFilter(filter, selectedFilter == filter, icon, context),
    );
  }

  // Construye la lista de propiedades utilizando AnimatedList
  Widget _buildPropertyList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: AnimatedList(
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

  // Construye un ítem de propiedad para la lista
  Widget _buildPropertyItem(PropertyCard propertyCard, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Hero(
        tag: propertyCard.imageUrl, // Asegúrate de que el nombre de la propiedad sea correcto
        child: PropertyCard(
          idPropiedad: propertyCard.idPropiedad,
          title: propertyCard.title,
          type: propertyCard.type,
          direction: propertyCard.direction,
          price: propertyCard.price,
          status: propertyCard.status,
          imageUrl: propertyCard.imageUrl, // Asegúrate de que el nombre de la propiedad sea correcto
          isFavorites: propertyCard.isFavorites,
        ),
      ),
    );
  }

  // Carga las propiedades de forma asíncrona
  Future<void> _loadProperties() async {
    setState(() {
      _isLoading = true; // Establecer estado de carga al comenzar
    });

    try {
      final properties = await PropertiesService().getProperties(); // Cargar propiedades desde el servicio

      // Crea una nueva lista de PropertyCard a partir de las propiedades
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
        );
      }).toList();

      setState(() {
        _propertyCards.clear(); // Limpiar la lista actual
        _propertyCards.addAll(newPropertyCards); // Agregar las nuevas tarjetas a la lista

        // Si estás utilizando AnimatedList, puedes usar insertItem aquí
        for (int i = 0; i < newPropertyCards.length; i++) {
          _listKey.currentState?.insertItem(i);
        }
      });
    } catch (e) {
      print('Error cargando propiedades: $e'); // Manejo de errores
    } finally {
      setState(() {
        _isLoading = false; // Cambiar el estado de carga
      });
    }
  }

  // Maneja la selección del filtro
  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  // Muestra el modal con los filtros
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
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filtros',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el modal
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Filter(), // Contenido del modal de filtros
            ],
          ),
        );
      },
    );
  }
}
