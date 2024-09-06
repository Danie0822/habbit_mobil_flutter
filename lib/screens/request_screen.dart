import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_requests.dart';
import 'package:habbit_mobil_flutter/common/widgets/detail_request.dart';
import 'package:habbit_mobil_flutter/data/models/request_model.dart';

// Pantalla principal que muestra una lista de RequestsCards con datos
class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de solicitudes
    final List<RequestModel> requestsData = [
      RequestModel(
        idSolicitud: 1,
        tituloSolicitud: 'Venta de Casa en la Playa',
        descripcionSolicitud: 'Descripción 1',
        direccionPropiedad: 'Calle 123, Playa Bonita',
        precioCasa: 250000.00,
        gananciaEmpresa: 5000.00,
        exclusividadComercializacion: 'Si',
        estadoSolicitud: 'Revisando',
        fechaSolicitud: '2024-09-01',
        nombreCliente: 'Cliente 1',
        telefonoCliente: '123456789',
        emailCliente: 'cliente1@example.com',
        idCliente: 1,
        nombreZona: 'Playa',
        nombreCategoria: 'Casa',
        idAdministrador: 1,
        nombreAdministrador: 'Admin 1',
      ),
      RequestModel(
        idSolicitud: 2,
        tituloSolicitud: 'Venta de Departamento en el Centro',
        descripcionSolicitud: 'Descripción 2',
        direccionPropiedad: 'Avenida Principal 456, Centro',
        precioCasa: 150000.00,
        gananciaEmpresa: 3000.00,
        exclusividadComercializacion: 'No',
        estadoSolicitud: 'Rechazada',
        fechaSolicitud: '2024-08-25',
        nombreCliente: 'Cliente 2',
        telefonoCliente: '987654321',
        emailCliente: 'cliente2@example.com',
        idCliente: 2,
        nombreZona: 'Centro',
        nombreCategoria: 'Departamento',
        idAdministrador: 2,
        nombreAdministrador: 'Admin 2',
      ),
      RequestModel(
        idSolicitud: 3,
        tituloSolicitud: 'Venta de Casa en las Afueras',
        descripcionSolicitud: 'Descripción 3',
        direccionPropiedad: 'Camino Real 789, Afueras',
        precioCasa: 100000.00,
        gananciaEmpresa: 2000.00,
        exclusividadComercializacion: 'Si',
        estadoSolicitud: 'Aceptada',
        fechaSolicitud: '2024-08-15',
        nombreCliente: 'Cliente 3',
        telefonoCliente: '456789123',
        emailCliente: 'cliente3@example.com',
        idCliente: 3,
        nombreZona: 'Afueras',
        nombreCategoria: 'Casa',
        idAdministrador: 3,
        nombreAdministrador: 'Admin 3',
      ),
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
          return GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => DetailRequest(context, request),
            ),
            child: RequestsCards(
              titulo: request.tituloSolicitud,
              administrador: request.nombreAdministrador,
              fecha: request.fechaSolicitud,
              estado: request.estadoSolicitud,
            ),
          );
        },
      ),
    );
  }
}
