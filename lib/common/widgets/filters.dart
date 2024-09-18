import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/data/controlers/categorys.dart'; // Controlador para categorías
import 'package:habbit_mobil_flutter/data/controlers/prices.dart';
import 'package:habbit_mobil_flutter/data/controlers/zones.dart'; // Controlador para zonas
import 'package:habbit_mobil_flutter/data/models/category.dart'; // Modelo de categorías
import 'package:habbit_mobil_flutter/data/models/prices.dart';
import 'package:habbit_mobil_flutter/data/models/zone.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart'; // Modelo de zonas

class Filter extends StatefulWidget {
  final void Function(int category, int zone, double min, double max)? onApplyFilters;

  const Filter({Key? key, this.onApplyFilters}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var selectedRange = const RangeValues(400, 1000);
  int selectedCategory = 0;
  int selectedZone = 0;
  double minPrice = 0;
  double maxPrice = 0;

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
      List<Category> fetchedCategories =
          await CategorysService().getCategories();
      List<Zone> fetchedZones = await ZonesSerivce().getZones();
      // Llama al controlador de precios para cargar el rango de precios.
      final PrecioRange range = await DataPrices().fetchPrecioRange();
      minPrice = range.minimo;
      maxPrice = range.maximo;

      // Asegurarse de que el rango seleccionado esté dentro de los valores válidos.
      setState(() {
        selectedRange = RangeValues(
          range.minimo.toDouble(),
          range.maximo.toDouble(),
        );
        categories = fetchedCategories;
        zones = fetchedZones;
        isLoading = false; // Cambiar el estado de carga
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Cambiar el estado de carga en caso de error
      });
    }
  }

  Widget buildCategoryOption(Category category) {
    bool selected = category.id == selectedCategory;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).primaryColor
              : Colors.transparent, // Fondo si está seleccionado
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected
                ? Theme.of(context).primaryColor
                : Colors.grey, // Cambiar color del borde
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            category.name,
            style: TextStyle(
              color:
                  selected ? Colors.white : null, // Cambiar el color del texto
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildZoneOption(Zone zone) {
    bool selected = zone.id == selectedZone;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedZone = zone.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).primaryColor
              : Colors.transparent, // Fondo si está seleccionado
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected
                ? Theme.of(context).primaryColor
                : Colors.grey, // Cambiar color del borde
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            zone.name,
            style: TextStyle(
              color:
                  selected ? Colors.white : null, // Cambiar el color del texto
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Aplica los filtros seleccionados
  void _applyFilters() {
    if (widget.onApplyFilters != null) {
      widget.onApplyFilters!(selectedCategory, selectedZone, selectedRange.start, selectedRange.end);
    }
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
                  min: minPrice,
                  max: maxPrice,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.grey[300],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${selectedRange.start.round()}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "\$${selectedRange.end.round()}",
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12), // Puedes ajustar el padding si lo deseas
                  ),
                  child: const Text(
                    "Aplicar Filtros",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold, // Texto en negrita si lo deseas
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
