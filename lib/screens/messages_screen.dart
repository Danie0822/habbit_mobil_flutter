import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor);
    
    final Color containerMessage = ThemeUtils.getColorBasedOnBrightness(
        context, contenedorMensajeLight, contenedorMensajeDark);

    final Color textName = ThemeUtils.getColorBasedOnBrightness(
        context, textColor, lightTextColor);
        
    return Scaffold(
      backgroundColor: colorBackGroundMessage,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mensajes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: whiteColor),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    color: whiteColor,
                    iconSize: 35.0,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: containerMain,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 35.0),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: containerMessage,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: textName.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Cambia la posición del sombreado
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Alessandro Morales',
                                    style: TextStyle(
                                      color: textName,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    '12:00',
                                    style: TextStyle(color: textName),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'alessandro.morales@gmail.com',
                                style: TextStyle(color: textName),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: containerMessage,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: textName.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Fernando Gomez',
                                    style: TextStyle(
                                      color: textName,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    '15:00',
                                    style: TextStyle(color: textName),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Hola, me gustas',
                                style: TextStyle(color: textName),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: containerMessage,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: textName.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Adriana Oreo',
                                    style: TextStyle(
                                      color: textName,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    '15:00',
                                    style: TextStyle(color: textName),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Hola, no me gusta la casa',
                                style: TextStyle(color: textName),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: containerMessage,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: textName.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Jose Sanchez',
                                    style: TextStyle(
                                      color: textName,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    '15:00',
                                    style: TextStyle(color: textName),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Hola, me gusta braw',
                                style: TextStyle(color: textName),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: containerMessage,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: textName.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Emiliano Jacobo',
                                    style: TextStyle(
                                      color: textName,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    '15:00',
                                    style: TextStyle(color: textName),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Holi',
                                style: TextStyle(color: textName),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: containerMessage,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: textName.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Oscar Gomez',
                                    style: TextStyle(
                                      color: textName,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    '15:00',
                                    style: TextStyle(color: textName),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Hola, me gustas',
                                style: TextStyle(color: textName),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: containerMessage,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: textName.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Daniel Gomez',
                                    style: TextStyle(
                                      color: textName,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    '15:00',
                                    style: TextStyle(color: textName),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Hola, me gustas',
                                style: TextStyle(color: textName),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
