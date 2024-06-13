import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;
  var selectedRange = RangeValues(400, 1000);

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

    return Scaffold(
      body: Column(
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
                            Text(
                              "Elige el precio máximo y mínimo",
                              style: AppStyles.headline5(context, colorTexto),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Selecciona un precio máximo y un precio mínimo de los que están en el rango",
                              style: AppStyles.subtitle1(context),
                            ),
                            const SizedBox(height: 50),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${selectedRange.start.round()}k", // Display start of range
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "\$${selectedRange.end.round()}k", // Display end of range
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 300),
                            Align(
                              alignment: Alignment.center,
                              child: CustomButton(
                                onPressed: () {
                                  context.push('/category');
                                },
                                text: "Siguiente",
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              })
        ],
      ),
    );
  }
}
