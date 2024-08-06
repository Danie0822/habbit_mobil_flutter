class CustomValidator {
  // Validación de correo electrónico
  static String? validateEmail(String? value) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  // Validación de números enteros
  static String? validateInteger(String? value) {
    final regExp = RegExp(r'^\d+$');

    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un número entero válido';
    }
    return null;
  }

  // Validación de números decimales
  static String? validateDecimal(String? value) {
    final regExp = RegExp(r'^\d+(\.\d+)?$');

    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un número decimal válido';
    }
    return null;
  }

  // Validación de alfanumérico con comas y puntos
  static String? validateAlphaNumericWithCommaAndDot(String? value) {
    final regExp = RegExp(r'^[a-zA-Z0-9,\.]+$');

    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese solo letras, números, comas o puntos';
    }
    return null;
  }

  // Validación de longitud de cadena
  static String? validateLength(String? value,
      {int minLength = 4, int maxLength = 100}) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (value.length < minLength) {
      return 'La longitud mínima es $minLength caracteres';
    } else if (value.length > maxLength) {
      return 'La longitud máxima es $maxLength caracteres';
    }
    return null;
  }
  static String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'El campo no puede estar vacío';
  } else if (value.length < 8) {
    return 'La contraseña debe tener al menos 8 caracteres';
  }
  return null;
}

//Validacion para los precios 
static String? validatePriceRange(double? start, double? end) {
    if (start == null || end == null) {
      return 'El valor de precio min y máx no puede ser null';
    } else if (start < 0 || end < 0) {
      return 'El valor de precio no puede ser negativo';
    } else if (start > end) {
      return 'El valor de precio min no puede ser mayor que el valor de precio máx';
    }
    return null;
  }
  // Validación de nombre 
  static String? validateName(String? value) {
    final regExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ]+$');
    
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (value.length < 3) {
      return 'La longitud mínima es 3 caracteres';
    } else if (value.length > 100) {
      return 'La longitud máxima es 100 caracteres';
    } else if (!regExp.hasMatch(value)) {
      return 'El nombre solo puede contener letras';
    }
    return null;
  }
    // Validación de teléfono 
  static String? validatePhoneNumber(String? value) {
    final regExp = RegExp(r'^[762]\d{3}-\d{4}$');
    
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un número de teléfono válido (0000-0000) comenzando con 7, 6 o 2';
    }
    return null;
  }
}



