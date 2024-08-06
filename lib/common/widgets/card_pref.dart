import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/styles/text.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class PrefWidget extends StatefulWidget {
  final String text;
  final String lottieUrl;
  final String destinationRoute;
  final int index;

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
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);
    _fadeController.forward();

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
