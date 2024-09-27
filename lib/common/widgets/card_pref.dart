import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class PrefWidget extends StatefulWidget {
  final String text; // texto
  final String lottieUrl; // url de la animación
  final String destinationRoute; // ruta de destino
  final int index; // índice

  const PrefWidget({
    Key? key,
    required this.text,
    required this.lottieUrl,
    required this.destinationRoute,
    required this.index,
  }) : super(key: key);

  @override
  _PrefWidgetState createState() => _PrefWidgetState();
}

class _PrefWidgetState extends State<PrefWidget> with TickerProviderStateMixin {
  // Controlador de animación de desvanecimiento
  late AnimationController _fadeController;
  // Animación de desvanecimiento
  late Animation<double> _fadeAnimation;
  // Controlador de animación de Lottie
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    // Inicializar controlador de animación de desvanecimiento
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // Inicializar animación de desvanecimiento
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);
    // Iniciar animación de desvanecimiento
    _fadeController.forward();
    // Inicializar controlador de animación de Lottie
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
    // Altura de la animación de Lottie
    final double lottieHeight = MediaQuery.of(context).size.height * 0.12;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColors,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 227, 226, 226).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.push(widget.destinationRoute);
        },
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Lottie.network(
                  widget.lottieUrl,
                  height: lottieHeight,
                  controller: _lottieController,
                  onLoaded: (composition) {
                    final double endFrame = composition.duration.inMilliseconds / 2;

                    _lottieController
                      ..duration = composition.duration
                      ..addStatusListener((status) {
                        if (status == AnimationStatus.completed) {
                          _lottieController.stop();
                        }
                      })
                      ..animateTo(endFrame / composition.duration.inMilliseconds);
                  },
                ),
              ),
              const SizedBox(height: 5),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  widget.text,
                  style: AppStyles.headline6(context, Colors.white),
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
