import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/constant_menu.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors_menu.dart';
import 'package:rive/rive.dart';

// Clase para la lista del menu de cada item
class MenuListScreen extends StatelessWidget {
  const MenuListScreen(
      {Key? key,
      required this.menu,
      required this.press,
      required this.riveonInit,
      required this.IsActive})
      : super(key: key);
  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool IsActive;
  // diseño de la lista del menu
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          // se estrablece el tamaño
          children: [
            // animacion de la lista del menu
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: IsActive ? 288 : 0,
              left: 0,
              child: Container(
                  decoration: const BoxDecoration(
                color: lightBlueBarColor2,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
            ),
            ListTile(
              // evento de la lista del menu al presionar el item
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riveonInit,
                ),
              ),
              // texto de la lista del menu
              title: Text(menu.title,
                  style: const TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
