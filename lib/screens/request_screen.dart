import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_requests.dart';
import 'package:habbit_mobil_flutter/common/widgets/detail_request.dart';
import 'package:habbit_mobil_flutter/data/controlers/request_controlers.dart';
import 'package:habbit_mobil_flutter/data/models/request_model.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<RequestModel> requestsData = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Cargar las solicitudes al inicializar el widget
    _loadRequests();
  }

  // Función para cargar solicitudes del cliente
  Future<void> _loadRequests() async {
    try {
      setState(() {
        isLoading = true; // Comienza la carga
      });
      // Llama al servicio para cargar las solicitudes
      final loadedRequests = await RequestService().cargarRequest();
      setState(() {
        requestsData = loadedRequests;
        isLoading = false; // Finaliza la carga
      });
    } catch (error) {
      // Manejo de errores
      setState(() {
        errorMessage = 'Error al cargar solicitudes: $error';
        isLoading = false; // Finaliza la carga con error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
             context.go('/newRequest');
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Muestra un indicador de carga
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!)) // Muestra el error si hay alguno
              : RefreshIndicator(
                onRefresh: _loadRequests,
                child: ListRequest(
                    requestsData:
                        requestsData),
              ), // Muestra la lista de solicitudes si no hay errores
    );
  }
}

class ListRequest extends StatelessWidget {
  const ListRequest({
    super.key,
    required this.requestsData,
  });

  final List<RequestModel> requestsData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
