import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';


Widget buildCategoryOption(String category, context, String selectedCategory, void Function(String) onSelected) {
  Color textColorText = ThemeUtils.getColorBasedOnBrightness(context, textColor, lightTextColor);
  bool selected = category == selectedCategory;
  return GestureDetector(
    onTap: () {
      onSelected(category);
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
          category,
          style: TextStyle(
            color: selected ? Colors.white : textColorText,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget buildZoneOption(String zone, context, String selectedZone, void Function(String) onSelected) {
  Color textColorText = ThemeUtils.getColorBasedOnBrightness(context, textColor, lightTextColor);
  bool selected = zone == selectedZone;
  return GestureDetector(
    onTap: () {
      onSelected(zone);
    },
    child: Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: selected ?Theme.of(context).primaryColor : Colors.grey,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          zone,
          style: TextStyle(
            color: selected ? Colors.white : textColorText,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}


