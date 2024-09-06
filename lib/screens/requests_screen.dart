import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_requests.dart';

// Pantalla principal que muestra una lista de RequestsCards con datos quemados
class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos quemados para mostrar en las tarjetas
    final List<Map<String, String>> requestsData = [
      {
        'titulo': 'Solicitud 1',
        'administrador': 'Admin 1',
        'fecha': '2024-09-01',
        'estado': 'Revisando',
      },
      {
        'titulo': 'Solicitud 2',
        'administrador': 'Admin 2',
        'fecha': '2024-08-25',
        'estado': 'Rechazada',
      },
      {
        'titulo': 'Solicitud 3',
        'administrador': 'Admin 3',
        'fecha': '2024-08-15',
        'estado': 'Aceptada',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: requestsData.length,
        itemBuilder: (context, index) {
          final request = requestsData[index];
          return RequestsCards(
            titulo: request['titulo']!,
            administrador: request['administrador']!,
            fecha: request['fecha']!,
            estado: request['estado']!,
          );
        },
      ),
    );
  }
}