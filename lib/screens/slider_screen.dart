import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/data/models/slider.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';

class SliderScreen extends StatefulWidget {
  final List<SliderResponse> cards;

  const SliderScreen({Key? key, required this.cards}) : super(key: key);

  @override
  State<SliderScreen> createState() => SliderScreenState();
}

class SliderScreenState extends State<SliderScreen> {
  late CardSwiperController controller;
  late List<SliderResponse> cards;
  late List<SliderResponse> originalCards;

  @override
  void initState() {
    super.initState();
    controller = CardSwiperController();
    cards = widget.cards;
    originalCards = List.from(widget.cards); // Guardar la lista original
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryBackground = ThemeUtils.getColorBasedOnBrightness(
        context, whiteColor, contenedorMensajeDark);

    final Color textoTitle = ThemeUtils.getColorBasedOnBrightness(
        context, textColorNegro, whiteColor);

    // Obtener el tamaño de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (cards.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('No se encontraron datos de tarjetas.',
              style: TextStyle(color: textColorNegro, fontSize: screenWidth * 0.05)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: primaryBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flecha y título
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: textoTitle, size: screenWidth * 0.08),
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                  ),
                  // Hacemos el título responsivo
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Nuestras recomendaciones',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07, // Escalado para mantener proporción
                          fontWeight: FontWeight.bold,
                          color: textoTitle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tarjetas
            Expanded(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
                onSwipe: (previousIndex, currentIndex, direction) {
                  if (currentIndex == cards.length - 1) {
                    showReloadDialog(context);
                  }
                  return true;
                },
                onUndo: (previousIndex, currentIndex, direction) {
                  debugPrint(
                    'The card $currentIndex was undone from the ${direction.name}',
                  );
                  return true;
                },
                numberOfCardsDisplayed: 3,
                backCardOffset: Offset(screenWidth * 0.1, screenHeight * 0.05), // Responsivo
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                cardBuilder: (context, index, horizontalThresholdPercentage,
                        verticalThresholdPercentage) =>
                    buildCard(cards[index], context),
              ),
            ),

            // Descripción al final
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02,
              ),
              child: Text(
                'Desliza para ver nuestras recomendaciones. Toca la tarjeta para ver más detalles.',
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // Escalado
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(SliderResponse card, BuildContext context) {
    final primaryBackground = ThemeUtils.getColorBasedOnBrightness(
        context, whiteColor, contenedorMensajeDark);

    final boxStyle = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageWidget, Colors.black.withOpacity(0.6));

    final Color texto =
        ThemeUtils.getColorBasedOnBrightness(context, whiteColor, whiteColor);

    // Obtener el tamaño de la pantalla para responsividad
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        context.push('/detalle', extra: {
          'id_propiedad': card.idProperty,
        });
      },
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Card(
          color: primaryBackground,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          child: Column(
            children: [
              // Imagen ocupando el 75% del espacio de la tarjeta
              Expanded(
                flex: 3, // 75% del espacio
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(screenWidth * 0.04)),
                  child: Image.network(
                    '${Config.imagen}${card.imageUrl}',
                    width: double.infinity,
                    fit: BoxFit.cover, // La imagen se ajusta sin distorsionar
                  ),
                ),
              ),
              // La información de la propiedad ocupando el 25% del espacio restante
              SingleChildScrollView(
                child: Expanded(
                  flex: 1, // 25% del espacio
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: boxStyle,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(screenWidth * 0.04),
                        bottomRight: Radius.circular(screenWidth * 0.04),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.propertyTitle ?? '',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06, // Ajustado para mantener proporción
                            fontWeight: FontWeight.bold,
                            color: texto,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          '${card.propertyType} - ${card.propertyState}',
                          style: TextStyle(fontSize: screenWidth * 0.045, color: texto),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          '${card.distanceKm?.toStringAsFixed(2)} km',
                          style: TextStyle(fontSize: screenWidth * 0.04, color: texto),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showReloadDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Recargar tarjetas",
            style: TextStyle(fontSize: screenWidth * 0.05),
          ),
          content: Text(
            "¿Deseas recargar las tarjetas?",
            style: TextStyle(fontSize: screenWidth * 0.045),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar", style: TextStyle(fontSize: screenWidth * 0.045)),
              onPressed: () {
                Navigator.of(context).pop();
                context.push('/recommend_option');
              },
            ),
            TextButton(
              child: Text("Recargar", style: TextStyle(fontSize: screenWidth * 0.045)),
              onPressed: () {
                setState(() {
                  cards = List.from(originalCards); // Restablece las tarjetas
                  controller =
                      CardSwiperController(); // Crea un nuevo controlador
                });
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }
}
