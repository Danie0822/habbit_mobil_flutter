import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class UbiScreen extends StatefulWidget {
  const UbiScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UbiScreenState();
}

class _UbiScreenState extends State<UbiScreen> {


  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Text(
            "Ubicación",
            style: AppStyles.headline5(context, colorTexto),
          ),
          const SizedBox(height: 10),
          Text(
            "Selecciona tu ubicación preferida",
            style: AppStyles.subtitle1(context),
          ),
          const SizedBox(height: 10),
          
            
          const SizedBox(height: 150),
          Align(
            alignment: Alignment.center,
            child: CustomButton(
              onPressed: () {
                context.push('/price');
              },
              text: "Siguiente",
            ),
          ),
        ],
      ),
    ));
  }
}
