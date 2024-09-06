import 'package:rive/rive.dart';

// Clase para obtener el controlador de la animación de Rive
class RiveUtils {
  // Animaciones rive es un archivo de animación que hace que pase de reposo a activo y viceversa
  // Método para obtener el controlador de la animación de Rive
  static StateMachineController getRiveController(Artboard artboard,
      {stateMachineName = "State Machine 1"}) {
    // Se obtiene el controlador de la animación de Rive
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller;
  }
}
