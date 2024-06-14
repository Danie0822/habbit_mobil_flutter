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
    Key? key,
    required this.text,
    required this.lottieUrl,
    required this.destinationRoute,
  }) : super(key: key);

  @override
  _PrefWidgetState createState() => _PrefWidgetState();
}

class _PrefWidgetState extends State<PrefWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Duración de la animación
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward(); // Inicia la animación cuando el widget se monta
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color colorTexto = Theme.of(context).brightness == Brightness.light
        ? secondaryColor
        : lightTextColor;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500), // Duración de la animación
      curve: Curves.easeInOut, // Curva de la animación
      margin: EdgeInsets.all(8), // Margen animado
      decoration: BoxDecoration(
        color: Colors.white, // Color de fondo animado
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Cambio animado de la sombra
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
              opacity: _animation, // Opacidad animada para el contenido
              child: Lottie.network(widget.lottieUrl, height: 100),
            ),
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _animation, // Opacidad animada para el contenido
              child: Text(
                widget.text,
                style: AppStyles.headlinee6(context, colorTexto),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
