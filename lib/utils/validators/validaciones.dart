class CustomValidator {
  // Validación de correo electrónico
  static String? validateEmail(String? value) {
    const pattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  // Validación de números enteros
  static String? validateInteger(String value) {
    final regExp = RegExp(r'^\d+$');

    if (value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un número entero válido';
    }
    return null;
  }

  // Validación de números decimales
  static String? validateDecimal(String value) {
    final regExp = RegExp(r'^\d+(\.\d+)?$');

    if (value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un número decimal válido';
    }
    return null;
  }

  // Validación de alfanumérico con comas y puntos
  static String? validateAlphaNumericWithCommaAndDot(String value) {
    final regExp = RegExp(r'^[a-zA-Z0-9,\.]+$');

    if (value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese solo letras, números, comas o puntos';
    }
    return null;
  }

  // Validación de longitud de cadena
  static String? validateLength(String value,
      {int minLength = 4, int maxLength = 100}) {
    if (value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (value.length < minLength) {
      return 'La longitud mínima es $minLength caracteres';
    } else if (value.length > maxLength) {
      return 'La longitud máxima es $maxLength caracteres';
    }
    return null;
  }
}
