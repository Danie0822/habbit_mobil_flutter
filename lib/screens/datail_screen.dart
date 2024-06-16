import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/feature_widget.dart';
import 'package:habbit_mobil_flutter/common/widgets/foto_widget.dart';
import 'package:habbit_mobil_flutter/data/data.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class PropertyDetailsScreen  extends StatelessWidget {
  final Property propiedad;

  const PropertyDetailsScreen ({required this.propiedad});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color colorTexto = ThemeUtils.getColorBasedOnBrightness(
        context, secondaryColor, lightTextColor);
    double horizontalPadding = size.width * 0.06;
    double verticalPadding = size.height * 0.02;

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: propiedad.frontImage,
            child: Container(
              height: size.height * 0.35,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(propiedad.frontImage),
                      fit: BoxFit.cover,
                    ),
                    gradient: RadialGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      radius: 0.5,
                      center: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.map,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          // Add map button functionality here
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding / 2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    width: size.width * 0.2,
                    padding:
                        EdgeInsets.symmetric(vertical: verticalPadding / 5),
                    child: Center(
                      child: Text(
                        propiedad.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          propiedad.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height: size.width * 0.13,
                        width: size.width * 0.13,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      top: verticalPadding / 2,
                      bottom: verticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: size.width * 0.01),
                          Text(
                            propiedad.location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.65,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daniel Morales",
                                style: AppStyles.headline6(context, colorTexto),
                              ),
                              SizedBox(height: verticalPadding / 4),
                              Text(
                                "Propietario",
                                style: AppStyles.subtitle1(context),
                              ),
                            ],
                          ),
                          Container(
                            height: size.width * 0.13,
                            width: size.width * 0.13,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.message,
                                color: Colors.blueAccent[700],
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: verticalPadding * 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildFeature(Icons.hotel, "3"),
                          buildFeature(Icons.bathtub, "2"),
                          buildFeature(Icons.directions_car, "1"),
                          buildFeature(Icons.dashboard_customize, "Casas"),
                          buildFeature(Icons.place, "Playa"),
                        ],
                      ),
                      SizedBox(height: verticalPadding * 1.5),
                      Text(
                        "Descripción",
                        style: AppStyles.headline6(context, colorTexto),
                      ),
                      SizedBox(height: verticalPadding / 2),
                      Text(
                        propiedad.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: verticalPadding * 1.5),
                      Text(
                        "Fotos",
                        style: AppStyles.headline6(context, colorTexto),
                      ),
                      SizedBox(height: verticalPadding / 2),
                      SizedBox(
                        height: size.height * 0.2,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: buildPhotos(context, propiedad.images),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
