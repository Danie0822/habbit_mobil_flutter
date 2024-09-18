import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
// ComboBox personalizado
class MyComboBox<T> extends StatelessWidget {
  const MyComboBox({
    Key? key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
    this.icon,
    this.validator,
    this.iconColor,
  }) : super(key: key);

  final String hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final T? value;
  final IconData? icon;
  final FormFieldValidator<T>? validator;
  final Color? iconColor;
  // Colores de los campos de texto
  @override
  Widget build(BuildContext context) {
    Color fillColor = ThemeUtils.getColorBasedOnBrightness(
        context, colorTextField, colorTextFieldDark);

    Color actualIconColor = iconColor ??
        ThemeUtils.getColorBasedOnBrightness(
            context, iconLightColor, iconDarkColor);

    // Si no hay valor seleccionado, selecciona el primer ítem de la lista.
    T? selectedValue = value ?? (items.isNotEmpty ? items.first.value : null);
    // Contenedor de ComboBox
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          // ComboBox 
          child: DropdownButtonFormField<T>(
            // Valor seleccionado
            value: selectedValue,
            items: items, // Ítems de la lista
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[500]!,
                fontSize: 16,
              ),
              prefixIcon: icon != null
                  ? Container(
                      padding: const EdgeInsets.all(12),
                      child: Icon(icon, color: actualIconColor),
                    )
                  : null,
              filled: true,
              fillColor: fillColor,
              errorMaxLines: 3,
            ),
            validator: validator,
            dropdownColor: fillColor,
            isExpanded: false, // Ajusta para que no ocupe todo el ancho
            icon: Icon(Icons.arrow_drop_down, color: actualIconColor),
            itemHeight: 50, // Ajusta la altura de cada ítem
          ),
        ),
      ),
    );
  }
}
