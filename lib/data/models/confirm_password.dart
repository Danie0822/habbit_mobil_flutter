// Modelo de datos para la confirmación de la contraseña
class ConfirmViewArguments {
  final int idUsuario;
  final String codigo;

  ConfirmViewArguments({required this.idUsuario, required this.codigo});
}