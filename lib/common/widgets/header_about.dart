import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

// Pantalla de header de Acerca de
class HeaderObout extends StatelessWidget {
  const HeaderObout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el color basado en el brillo del tema
    final Color containerColor = ThemeUtils.getColorBasedOnBrightness(
      context, 
      contenedorMensajeLight, 
      contenedorMensajeDark
    );
    // Diseño de la AppBar
    return SliverAppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      expandedHeight: 275.0,
      elevation: 0.0,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/house_01.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.4), // Overlay darkening
            ),
          ],
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: Container(
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
            color: containerColor, // Background color of the bottom area
          ),
          child: Container(
            width: 50.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
        ),
      ),
      leadingWidth: 80.0,
      leading: Container(
        margin: const EdgeInsets.only(left: 24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(56.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Regresar atrás cuando se toque la imagen
              },
              child: Container(
                height: 56.0,
                width: 56.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.30), // Slightly less opacity for better visibility
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black87, // Changed icon color for better contrast
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
