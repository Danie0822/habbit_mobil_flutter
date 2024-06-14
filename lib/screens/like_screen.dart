import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/appbar.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_property.dart';
import 'package:habbit_mobil_flutter/data/data.dart';

class LikeScreen extends StatefulWidget {
  LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  List<Property> properties = getPropertyList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TAppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Guardados",
                    style: Theme.of(context).textTheme.headlineSmall!.apply(
                        color: const Color.fromARGB(255, 255, 255, 255))),
              ],
            ),
            action: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 25.0,
                ),
                tooltip: 'Profile', 
                splashColor: Colors
                    .blue,
                highlightColor:
                    Color.fromARGB(255, 24, 1, 131), 
                padding: EdgeInsets.symmetric(horizontal: 20.0), 
                iconSize: 25.0,
              )
            ],
          ),
          SizedBox(height: 10.0),
          _buildPropertyList(),
        ],
      ),
    );
  }

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
              child: PropertyCard(property: properties[index], index: index),
            );
          },
        ),
      ),
    );
  }
}
