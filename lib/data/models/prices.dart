class PrecioRange {
  // Atributos de la clase PrecioRange
  final double minimo;
  final double maximo;
  // Constructor de la clase PrecioRange
  PrecioRange({required this.minimo, required this.maximo});

  // Método para convertir JSON a un objeto PrecioRange
  factory PrecioRange.fromJson(Map<String, dynamic> json) {
    return PrecioRange(
      minimo: json['minimo'].toDouble(),
      maximo: json['maximo'].toDouble(),
    );
  }
}
