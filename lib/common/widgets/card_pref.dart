import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class PrefWidget extends StatefulWidget {
  final String text;
  final String lottieUrl;
  final String destinationRoute;

  const PrefWidget({
    super.key,
    required this.text,
    required this.lottieUrl,
    required this.destinationRoute,
  });

  @override
  _PrefWidgetState createState() => _PrefWidgetState();
}

class _PrefWidgetState extends State<PrefWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    // Inicializa el controlador de animación de opacidad
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), 
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
      duration: const Duration(milliseconds: 500), 
      curve: Curves.easeInOut, 
      margin: EdgeInsets.all(8), 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Cambio animado de la sombra
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.push(widget.destinationRoute);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _fadeAnimation, 
              child: Lottie.network(
                widget.lottieUrl,
                height: 85,
                controller: _lottieController,
                onLoaded: (composition) {
                  //final double startFrame = 0.0; // Frame de inicio
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
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _fadeAnimation, 
              child: Text(
                widget.text,
                style: AppStyles.headlinee6(context, colorTexto),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
