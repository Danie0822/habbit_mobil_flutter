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
  // Variables para almacenar los datos de las solicitudes
  List<RequestModel> requestsData = [];
  bool isLoading = true;
  String? errorMessage;
  // Método para cargar solicitudes
  @override
  void initState() {
    super.initState();
    _loadRequests(); // Cargar solicitudes al iniciar
  }

  // Función para cargar solicitudes
  Future<void> _loadRequests() async {
    try {
      setState(() {
        isLoading = true;
      });
      final loadedRequests = await RequestService().cargarRequest(); // Cargar solicitudes
      setState(() {
        requestsData = loadedRequests;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error al cargar solicitudes: $error';
        isLoading = false;
      });
    }
  }
  // Diseño de la pantalla de solicitudes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la pantalla
      appBar: AppBar(
        title: const Text(
          'Solicitudes',
          style: TextStyle(
            fontSize: 24, // Tamaño del título
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12), // Esquinas redondeadas
          ),
        ),
      ),
      // Cuerpo de la pantalla
      body: isLoading // Mostrar indicador de carga si isLoading es verdadero
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!),
                )
              : RefreshIndicator( // Actualizar la lista de solicitudes
                  onRefresh: _loadRequests,
                  child: ListRequest(requestsData: requestsData),
                ),
      // Botón flotante para agregar una nueva solicitud
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/newRequest');
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
// Clase para mostrar la lista de solicitudes
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
            builder: (context) => DetailRequest(context, request), // Mostrar detalles de la solicitud
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Borde redondeado
            ),
            elevation: 4, // Sombra para mayor profundidad
            // Tarjeta de solicitud
            child: RequestsCards(
              titulo: request.tituloSolicitud,
              administrador: request.nombreAdministrador,
              fecha: request.fechaSolicitud,
              estado: request.estadoSolicitud,
            ),
          ),
        );
      },
    );
  }
}
