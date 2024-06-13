import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class ZoneScreen extends StatefulWidget {
  const ZoneScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ZoneScreenState();
}

class _ZoneScreenState extends State<ZoneScreen> {
  final List<String> _radioItems = [
    "Norte",
    "Sur",
    "Este",
    "Oeste",
    "Playa",
    "Montaña"
  ];
  String? _selectedRadioItem;

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
            "Zona",
            style: AppStyles.headline5(context, colorTexto),
          ),
          const SizedBox(height: 10),
          Text(
            "Selecciona la zona preferida para tu propiedad",
            style: AppStyles.subtitle1(context),
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < _radioItems.length; i++)
            RadioListTile<String>(
              value: _radioItems[i],
              groupValue: _selectedRadioItem,
              onChanged: (value) {
                setState(() {
                  _selectedRadioItem = value!;
                });
              },
              title: Text(_radioItems[i]),
              activeColor: colorTextYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          const SizedBox(height: 150),
          Align(
            alignment: Alignment.center,
            child: CustomButton(
              onPressed: () {
                context.push('/thanks');
              },
              text: "Terminar",
            ),
          ),
        ],
      ),
    ));
  }
}
