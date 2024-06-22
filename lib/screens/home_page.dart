import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/buildFilter.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_property.dart';
import 'package:habbit_mobil_flutter/common/widgets/filters.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_search.dart';
import 'package:habbit_mobil_flutter/data/data.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista de propiedades
  List<Property> properties = getPropertyList();
  // Filtro seleccionado
  String selectedFilter = 'Inmuebles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),  // Barra de búsqueda
          _buildFilterOptions(),  // Opciones de filtro
          _buildPropertyList(),  // Lista de propiedades
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
            onTap: _showBottomSheet,  // Muestra el modal de filtros
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
      onTap: () => _onFilterSelected(filter),  // Maneja la selección del filtro
      child: buildFilter(filter, selectedFilter == filter, icon, context),
    );
  }

  // Construye la lista de propiedades
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
              child: PropertyCard(
                property: properties[index], 
                index: index, 
                isFavorites: false,
              ),
            );
          },
        ),
      ),
    );
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
                      context.pop();  // Cierra el modal
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Filter(),  // Contenido del modal de filtros
            ],
          ),
        );
      },
    );
  }
}
