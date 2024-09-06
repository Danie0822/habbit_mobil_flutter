import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/header_menu.dart';
import 'package:habbit_mobil_flutter/common/widgets/menu_list.dart';
import 'package:habbit_mobil_flutter/data/models/menu_model.dart';
import 'package:habbit_mobil_flutter/utils/constants/constant_menu.dart';
import 'package:habbit_mobil_flutter/utils/constants/rive_utilis.dart';
import 'package:rive/rive.dart';

// Diseño de el menu de la pantalla principal
class MenuHome extends StatefulWidget {
  final Function(RiveAsset menu) onMenuSelected;

  const MenuHome({super.key, required this.onMenuSelected});

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

// Clase para el menu de la pantalla principal
class _MenuHomeState extends State<MenuHome> {
  RiveAsset selectedMenu = sideMenu.first;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth * 0.8, // usa el 80% del ancho de la pantalla
        height: screenHeight, // usa el 100% del alto de la pantalla
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderMenu(), // Encabezado del menu de la pantalla principal
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 20, bottom: 10),
                // texto de menu
                child: Text(
                  'Menu'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              Expanded(
                // lista de los items del menu
                child: ListView(
                  children: [
                    ...sideMenu.map(
                      // Se mapea la lista del menu en items
                      (menu) =>  MenuListScreen(
                      menu: menu, // Menu item
                      riveonInit: (artboard) {
                        // se obtiene el controlador de la animacion
                        StateMachineController controller = RiveUtils.getRiveController(
                          artboard,
                          stateMachineName: menu.stateMachineName,
                        );
                        menu.input = controller.findSMI('active') as SMIBool;  // se obtiene el estado de la animacion del menu item
                      },
                        // evento de la lista del menu al presionar el item
                        press: () {
                          // se cambia el estado del menu
                          menu.input!.change(true);
                          MenuModel().updateScreen(menu.screen);
                          widget.onMenuSelected(menu);
                          menu.input!.change(true);
                          Future.delayed(const Duration(seconds: 1), () {
                            menu.input!.change(false);
                          });
                          setState(() {
                            selectedMenu = menu;
                          });
                        },
                        IsActive: selectedMenu == menu,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
