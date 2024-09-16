import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/data/controlers/categorys.dart'; // Controlador para categorías
import 'package:habbit_mobil_flutter/data/controlers/zones.dart'; // Controlador para zonas
import 'package:habbit_mobil_flutter/data/models/category.dart'; // Modelo de categorías
import 'package:habbit_mobil_flutter/data/models/zone.dart'; // Modelo de zonas

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var selectedRange = const RangeValues(400, 1000);
  String selectedCategory = "";
  String selectedZone = "";

  // Listas que almacenarán los datos de la API.
  List<Category> categories = [];
  List<Zone> zones = [];
  bool isLoading = true; // Estado de carga

  // Cargar categorías y zonas de la API
  @override
  void initState() {
    super.initState();
    _loadFiltersData();
  }

  Future<void> _loadFiltersData() async {
    try {
      // Llama a los controladores para cargar las categorías y zonas.
      List<Category> fetchedCategories = await CategorysService().getCategories();
      List<Zone> fetchedZones = await ZonesSerivce().getZones();

      setState(() {
        categories = fetchedCategories;
        zones = fetchedZones;
        isLoading = false; // Cambiar el estado de carga
      });
    } catch (e) {
      print("Error al cargar categorías y zonas: $e");
      setState(() {
        isLoading = false; // Cambiar el estado de carga en caso de error
      });
    }
  }

  // Función para construir la opción de categoría.
  Widget buildCategoryOption(Category category) {
    bool selected = category.name == selectedCategory;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category.name;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? Theme.of(context).primaryColor : Colors.grey,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            category.name,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Función para construir la opción de zona.
  Widget buildZoneOption(Zone zone) {
    bool selected = zone.name == selectedZone;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedZone = zone.name;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? Theme.of(context).primaryColor : Colors.grey,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            zone.name,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator()) // Indicador de carga
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rango de Precios",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RangeSlider(
                  values: selectedRange,
                  onChanged: (RangeValues newRange) {
                    setState(() {
                      selectedRange = newRange;
                    });
                  },
                  min: 70,
                  max: 1000,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey[300],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${selectedRange.start.round()}k",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "\$${selectedRange.end.round()}k",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Categorías",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return buildCategoryOption(categories[index]);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Zonas",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: zones.length,
                    itemBuilder: (context, index) {
                      return buildZoneOption(zones[index]);
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
