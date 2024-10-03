import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/data/controlers/categorys.dart'; // Controlador para categorías
import 'package:habbit_mobil_flutter/data/controlers/prices.dart'; // Controlador para precios
import 'package:habbit_mobil_flutter/data/controlers/zones.dart'; // Controlador para zonas
import 'package:habbit_mobil_flutter/data/models/category.dart'; // Modelo de categorías
import 'package:habbit_mobil_flutter/data/models/prices.dart'; // Modelo de precios
import 'package:habbit_mobil_flutter/data/models/zone.dart'; // Modelo de zonas
import 'package:habbit_mobil_flutter/utils/constants/colors.dart'; // Constantes de colores

class Filter extends StatefulWidget {
  // Función para aplicar los filtros
  final void Function(int category, int zone, double min, double max)?
      onApplyFilters;

  const Filter({Key? key, this.onApplyFilters}) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  // Rango de precios seleccionado
  var selectedRange = const RangeValues(400, 1000);
  // Categoría seleccionada
  int selectedCategory = 0;
  // Zona seleccionada
  int selectedZone = 0;
  // Precio mínimo
  double minPrice = 0;
  // Precio máximo
  double maxPrice = 0;

  // Listas que almacenarán los datos de la API.
  List<Category> categories = [];
  List<Zone> zones = [];
  bool isLoading = true; // Estado de carga

  // Cargar categorías, zonas y precios de la API
  @override
  void initState() {
    super.initState();
    _loadFiltersData();
  }

  // Cargar categorías, zonas y precios de la API
  Future<void> _loadFiltersData() async {
    try {
      // Llama a los controladores para cargar las categorías, zonas y precios.
      List<Category> fetchedCategories =
          await CategorysService().getCategories();
      List<Zone> fetchedZones = await ZonesSerivce().getZones();
      final PrecioRange range = await DataPrices().fetchPrecioRange();

      setState(() {
        // Añadir manualmente la categoría "Todo" con id 0
        fetchedCategories.insert(0, Category(id: 0, name: "Todos"));
        fetchedZones.insert(0, Zone(id: 0, name: "Todos"));
        minPrice = range.minimo.toDouble();
        maxPrice = range.maximo.toDouble();
        selectedRange = RangeValues(minPrice, maxPrice);
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

  // Construir opción de categoría
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
              color: selected ? Colors.white : null,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Construir opción de zona
  Widget buildZoneOption(Zone zone) {
    bool selected = zone.id == selectedZone;
    // Devuelve un GestureDetector con la opción de zona
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
              color: selected ? Colors.white : null,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Aplicar filtros
  void _applyFilters() {
    if (widget.onApplyFilters != null) {
      widget.onApplyFilters!(selectedCategory, selectedZone,
          selectedRange.start, selectedRange.end);
    }
  }

 @override
Widget build(BuildContext context) {
  return isLoading
      ? const Center(child: CircularProgressIndicator())
      : Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView( // Añadido SingleChildScrollView
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
                minPrice != 0 && maxPrice != 0
                    ? Column(
                        children: [
                          RangeSlider(
                            values: selectedRange,
                            onChanged: (RangeValues newRange) {
                              // Verificar que los valores estén dentro del rango
                              if (newRange.start >= minPrice &&
                                  newRange.end <= maxPrice) {
                                setState(() {
                                  selectedRange = newRange;
                                });
                              }
                            },
                            min: minPrice,
                            max: maxPrice,
                            activeColor: primaryColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${selectedRange.start.round()}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                "\$${selectedRange.end.round()}",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(), // Loader mientras carga precios
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
                        horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    "Aplicar Filtros",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
}

}
