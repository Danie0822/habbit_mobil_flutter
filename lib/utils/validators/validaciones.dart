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
    final regExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');

    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (value.length < 3) {
      return 'La longitud mínima es 3 caracteres';
    } else if (value.length > 100) {
      return 'La longitud máxima es 100 caracteres';
    } else if (!regExp.hasMatch(value)) {
      return 'El nombre solo puede contener letras y espacios';
    }
    return null;
  }

// Validación de teléfono
  static String? validatePhoneNumber(String? value) {
    final regExp = RegExp(r'^\d{4}-\d{4}$');
    final validStart = RegExp(r'^[762]');

    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un número de teléfono válido en el formato 0000-0000';
    } else if (!validStart.hasMatch(value)) {
      return 'El número debe comenzar con 7, 6 o 2';
    }
    return null;
  }

  // Validación de títulos con caracteres especiales permitidos
  static String? validateTitle(String? value, int maxLength, String fieldName) {
    final regExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s,.;:$]+$');
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    } else if (value.length < 6 || value.length > maxLength) {
      return 'El $fieldName debe tener al menos 6 caracteres y menos de $maxLength caracteres';
    } else if (!regExp.hasMatch(value)) {
      return 'Solo se permiten letras, números, espacios, comas, puntos, punto y coma, dos puntos, y signo de dólar';
    }
    return null;
  }

  // Nueva validación de precios decimales
  static String? validateDecimalPrice(String? value) {
    final regExp = RegExp(
        r'^\d{1,8}(\.\d{1,2})?$'); // Acepta hasta 10 dígitos antes del punto y hasta 2 dígitos después

    if (value == null || value.isEmpty) {
      return 'El precio es obligatorio';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un precio válido con hasta 8 dígitos enteros y hasta 2 decimales';
    } else if (double.tryParse(value) == null) {
      return 'El precio debe ser un número válido';
    } else if (double.tryParse(value)! <= 0) {
      return 'El precio debe ser mayor a 0';
    }
    return null;
  }
}
