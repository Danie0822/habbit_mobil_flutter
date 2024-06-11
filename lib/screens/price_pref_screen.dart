
import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
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

  final List<String> _checkboxItems = ["100k", "50k", "300k"];
  List<bool> _checkboxValues = List.filled(3, false);

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
    final theme = Theme.of(context);
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Column(
        children: [
          AnimatedBuilder(
              animation: _fadeInAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeInAnimation.value,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: const BorderRadius.only(
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
                              "Precio máximo y mínimo",
                              style: AppStyles.headline5(context, colorTexto),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Selecciona el precio máximo",
                              style: AppStyles.subtitle1(context),
                            ),
                            for (int i = 0; i < _checkboxItems.length; i++)
                            CheckboxListTile(
                                  value: _checkboxValues[i],
                                  onChanged: (value) {
                                    _checkboxValues[i] = value!;
                                    setState(() {});
                                  },
                                  title: Text(_checkboxItems[i]),
                                  activeColor: Colors.yellowAccent,
                            )
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
