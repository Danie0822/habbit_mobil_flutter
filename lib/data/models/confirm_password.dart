// Modelo de datos para la confirmación de la contraseña
class ConfirmViewArguments {
  // ID del usuario
  final int idUsuario;
  // Código de confirmación
  final String codigo;
  // Constructor de la clase ConfirmViewArguments
  ConfirmViewArguments({required this.idUsuario, required this.codigo});
}
