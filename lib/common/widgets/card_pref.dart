import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class PrefWidget extends StatefulWidget {
  final String text;
  final String lottieUrl;
  final String destinationRoute;
  final int index; // Índice de la tarjeta

  const PrefWidget({
    super.key,
    required this.text,
    required this.lottieUrl,
    required this.destinationRoute,
    required this.index, // Índice de la tarjeta
  });

  @override
  _PrefWidgetState createState() => _PrefWidgetState();
}

class _PrefWidgetState extends State<PrefWidget> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    // Inicializa el controlador de animación de opacidad
    _fadeController = AnimationController(
      vsync: this,
      duration:
        const  Duration(milliseconds: 500), // Duración de la animación de aparición
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);
    _fadeController.forward(); // Inicia la animación cuando el widget se monta

    // Inicializa el controlador de animación de Lottie
    _lottieController = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return AnimatedContainer(
      duration: const  Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColors, // Color de fondo animado
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 227, 226, 226).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // Cambio animado de la sombra
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.push(widget.destinationRoute);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Lottie.network(
                  widget.lottieUrl,
                  height: 90,
                  controller: _lottieController,
                  onLoaded: (composition) {
                    final double endFrame = composition
                            .duration.inMilliseconds /
                        2; // Aquí defines el punto de parada (en este caso, la mitad)

                    _lottieController
                      ..duration = composition.duration
                      ..addStatusListener((status) {
                        if (status == AnimationStatus.completed) {
                          _lottieController.stop();
                        }
                      })
                      ..animateTo(endFrame /
                          composition.duration
                              .inMilliseconds); // Anima hasta el frame final definido
                  },
                ),
              ),
              const SizedBox(height: 5),
              FadeTransition(
                opacity: _fadeAnimation, // Opacidad animada para el contenido
                child: Text(
                  widget.text,
                  style: AppStyles.headline6(context, colorTexto),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
