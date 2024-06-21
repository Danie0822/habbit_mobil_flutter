//Importacion de paquetes a utilizar
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/common/widgets/button.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

//Creación y construcción de stateful widget llamado price screen
class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  //Definimos los valores para el rango
  var selectedRange = RangeValues(500, 1000);

  @override
  void initState() {
    super.initState();

    //Creacion para animacion de la pantalla
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

// Método build que define la interfaz de usuario del widget
  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

//Incio de la construccion de la pantalla
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.05,
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
                        vertical: height * 0,
                        horizontal: width * 0.01,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.08),
                          //Widget que muestra el texto
                          Text(
                            "Elige el precio máximo y mínimo",
                            style: AppStyles.headline5(context, colorTexto),
                          ),
                          SizedBox(height: height * 0.01),
                          //Widget que muestra el texto
                          Text(
                            "Selecciona un precio máximo y un precio mínimo de los que están en el rango",
                            style: AppStyles.subtitle1(context),
                          ),
                          SizedBox(height: height * 0.05),
                          //Widget que se encarga del control deslizante que muestra los distintos valores para el precio
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
                              //Textos que muestran el valor seleccionado en el slider
                              Text(
                                "\$${selectedRange.start.round()}k",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              //Textos que muestran el valor seleccionado en el sliders
                              Text(
                                "\$${selectedRange.end.round()}k",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.3),
                          Align(
                            alignment: Alignment.center,
                            //Boton para pasar a la siguiente pantalla
                            child: CustomButton(
                              onPressed: () {
                                context.push('/category');
                              },
                              text: "Siguiente",
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
