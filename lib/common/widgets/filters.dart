import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/build_option_filter.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  // Rango de precios seleccionado inicialmente.
  var selectedRange = const RangeValues(400, 1000);
  // Categoría y zona seleccionadas inicialmente.
  String selectedCategory = "Casas";
  String selectedZone = "Playa";

  // Actualiza la categoría seleccionada.
  void updateSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  // Actualiza la zona seleccionada.
  void updateSelectedZone(String zone) {
    setState(() {
      selectedZone = zone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Muestra el rango de precios seleccionado.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${selectedRange.start.round()}k", // Muestra el inicio del rango.
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                "\$${selectedRange.end.round()}k", // Muestra el final del rango.
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildCategoryOption("Casas", context, selectedCategory, updateSelectedCategory),
                buildCategoryOption("Departamentos", context, selectedCategory, updateSelectedCategory),
                buildCategoryOption("Oficinas", context, selectedCategory, updateSelectedCategory),
                buildCategoryOption("Terrenos", context, selectedCategory, updateSelectedCategory),
              ],
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildZoneOption("Playa", context, selectedZone, updateSelectedZone),
                buildZoneOption("Central", context, selectedZone, updateSelectedZone),
                buildZoneOption("Montaña", context, selectedZone, updateSelectedZone),
                buildZoneOption("Campo", context, selectedZone, updateSelectedZone),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
