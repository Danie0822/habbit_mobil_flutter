import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/buildFilter.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_property.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_search.dart';
import 'package:habbit_mobil_flutter/data/data.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Property> properties = getPropertyList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 10),
            child: TextFieldSearch(),
          ),
          Padding(
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
                        buildFilter('Inmuebles', true, Icons.home),
                        buildFilter('Proyectos', false, Icons.work),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    'Filtros',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: ListView.builder(
                padding: const EdgeInsets.only(right: 24, left: 24, top: 5),
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  return Hero(
                    tag: properties[index].frontImage,
                    child: buildProperty(properties[index], index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
