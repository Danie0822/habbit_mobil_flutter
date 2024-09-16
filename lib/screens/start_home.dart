import 'dart:math';
import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/menu_btn.dart';
import 'package:habbit_mobil_flutter/common/widgets/menu_home.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/constants/constant_menu.dart';
import 'package:habbit_mobil_flutter/utils/constants/rive_utilis.dart';
import 'package:rive/rive.dart';

// Pantalla de inicio con menu lateral
class StartHome extends StatefulWidget {
  const StartHome({super.key});

  @override
  State<StartHome> createState() => _StartHomeState();
}

// Clase para la pantalla de inicio
class _StartHomeState extends State<StartHome>
    with SingleTickerProviderStateMixin {
  // Animaciones y contraladores de dashboard
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> ScaleAnimation;
  late SMIBool isMenuOpen;
  bool IsSideMenuClose = true;
  bool cambioWidget = false;
  bool isSideMenuClose = true;
  RiveAsset selectedMenu = sideMenu.first;
  // metodo para abrir y cerrar el menu
  void toggleSideMenu() {
    setState(() {
      isSideMenuClose = !isSideMenuClose;
    });
  }

  // Metodo para inicializar el estado de la pantalla
  @override
  void initState() {
    _animationController = AnimationController(
      // Controlador de la animacion
      vsync: this,
      duration: const Duration(microseconds: 200), // duracion de la animacion
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        // Animacion de la pantalla
        parent: _animationController,
        curve: Curves.fastOutSlowIn));
    ScaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  // Metodo para cerrar la pantalla
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Diseño de la pantalla de inicio
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // diseño de dashboard
      backgroundColor: primaryColor, // color de fondo
      resizeToAvoidBottomInset: false, // no se redimensiona la pantalla
      extendBody: true,
      body: Stack(
        children: [
          // animacion de la pantalla
          AnimatedPositioned(
            // duracion de la animacion
            duration: const Duration(microseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288, // ancho de la pantalla del menu lateral
            left: IsSideMenuClose
                ? -288
                : 0, // posicion de la pantalla del menu lateral cuando esta cerrado
            height: MediaQuery.of(context).size.height, // alto de la pantalla
            child: MenuHome(onMenuSelected: (menu) {
              // Diseño del menu lateral
              setState(() {
                selectedMenu = menu;
              });
            }),
          ),
          // animacion de la pantalla
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
                offset: Offset(animation.value * 250, 0),
                child: Transform.scale(
                    scale: ScaleAnimation.value,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(
                            IsSideMenuClose
                                ? 0
                                : 24)), // borde de la pantalla de inicio
                        child: selectedMenu.screen))), // pantalla de inicio
          ),
          // animacion de la pantalla
          AnimatedPositioned(
            // duracion de la animacion
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left:
                IsSideMenuClose ? 0 : 220, // posicion de la pantalla de inicio
            top: 1,
            child: MenuBtnScreen(
              // boton de menu
              riveOnInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: 'State Machine');
                isMenuOpen = controller.findSMI('isOpen')
                    as SMIBool; // estado del menu abierto o cerrado
                isMenuOpen.value = true; // estado del menu abierto
              },
              press: () {
                // evento de abrir y cerrar el menu
                isMenuOpen.value = !isMenuOpen.value;
                if (IsSideMenuClose) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                // estado del menu se cambiara
                setState(() {
                  IsSideMenuClose = isMenuOpen.value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
