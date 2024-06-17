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

class _ZoneScreenState extends State<ZoneScreen> with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

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
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeInOut),
    );
    _fadeInController.forward();
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0,
          horizontal: width * 0.03,
        ),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _fadeInAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeInAnimation.value,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.02,
                        horizontal: width * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.08),
                          Text(
                            "Elige una Zona",
                            style: AppStyles.headline5(context, colorTexto),
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            "Selecciona una zona para mostrarte propiedades similares",
                            style: AppStyles.subtitle1(context),
                          ),
                          SizedBox(height: height * 0.02),
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
                          SizedBox(height: height * 0.2),
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
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
