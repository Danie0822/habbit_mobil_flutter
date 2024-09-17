import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/data/controlers/blogs_rating.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class RatingModal extends StatefulWidget {
  final int idSolicitud;
  const RatingModal({Key? key, required this.idSolicitud}) : super(key: key);

  @override
  State<RatingModal> createState() => _RatingModalState();
}

class _RatingModalState extends State<RatingModal> {
  final blogsRating _updateController = blogsRating();
  int _userRating = 0; // Valoración del usuario
  String _errorMessage = ''; // Mensaje de error si no selecciona estrellas

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5), // Fondo semitransparente
      body: Center(
        child: _buildRatingCard(size, isDarkMode),
      ),
    );
  }

void _updateInfo() async {
  try {
    final result = await _updateController.ratingSend(widget.idSolicitud, _userRating);
    if (result == 1) {
      showAlertDialog(
          'Éxito', 'Se ha enviando la operación exitosamente', 3, context,
          );
    } else if (result == 2) {
      showAlertDialog(
          'Error',
          'No se puede agregar la volariocion, ya que ya se ha realizado una valoracion',
          2,
          context);
    } else {
      showAlertDialog(
          'Error',
          'Ocurrió un error al enviar la solicitud. Por favor, intenta de nuevo.',
          2,
          context);
    }
  } catch (e) {
    showAlertDialog(
        'Error',
        'Ocurrió un error inesperado: $e',
        2,
        context);
  }
}



  // Método para construir la carta de selección de estrellas
  Widget _buildRatingCard(Size size, bool isDarkMode) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isDarkMode ? Colors.black : Colors.white,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Selecciona tu valoración',
              style: TextStyle(
                fontSize: size.width * 0.06,
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _buildRatingStars(), // Construir estrellas para seleccionar
            SizedBox(height: size.height * 0.02),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(
                  color: Colors.red, // Color del mensaje de error
                  fontSize: size.width * 0.045,
                ),
              ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cerrar el modal sin guardar
                  },
                  child: Text('Cancelar',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: size.width * 0.05,
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_userRating == 0) {
                      setState(() {
                        _errorMessage = 'Por favor selecciona al menos una estrella';
                      });
                    } else {
                      
                      _updateInfo();
                      context.pop(); // Cerrar el modal y guardar la valoración
                     
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // Color constante
                    foregroundColor: Colors.white, // Texto blanco
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Más cuadrado
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Tamaño del botón
                  ),
                  child: Text(
                    'Guardar',
                    style: TextStyle(
                      fontSize: size.width * 0.05,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir las estrellas de selección
  Widget _buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _userRating ? Icons.star : Icons.star_border, // Estrella llena o vacía
            color: Colors.amber,
            size: 40,
          ),
          onPressed: () {
            setState(() {
              _userRating = index + 1; // Actualiza la valoración seleccionada
              _errorMessage = ''; // Limpiar el mensaje de error si selecciona una estrella
            });
          },
        );
      }),
    );
  }
}
