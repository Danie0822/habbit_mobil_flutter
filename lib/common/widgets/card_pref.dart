import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class PrefWidget extends StatelessWidget {
  final String url;
  final String text;

  const PrefWidget({Key? key, required this.url, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: NetworkImage(url),
            height: 240,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {},
            ),
          ),
          Text(
            text,
            style: AppStyles.headline5(context, colorTexto),
          ),
        ],
      ),
    );
  }
}
