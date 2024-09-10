import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_requests.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
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
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    try {
      setState(() {
        isLoading = true;
      });
      final loadedRequests = await RequestService().cargarRequest();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solicitudes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : RefreshIndicator(
                  onRefresh: _loadRequests,
                  child: ListRequest(requestsData: requestsData),
                ),
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

class ListRequest extends StatelessWidget {
  const ListRequest({super.key, required this.requestsData});

  final List<RequestModel> requestsData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: requestsData.length,
      itemBuilder: (context, index) {
        final request = requestsData[index];

        return Dismissible(
          key: ValueKey(request.idSolicitud),
          direction: DismissDirection
              .endToStart, // Permite deslizar de derecha a izquierda
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
          ),
          onDismissed: (direction) {},
          confirmDismiss: (direction) async {
            // Confirmar la acción de eliminar
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmar'),
                content:
                    const Text('¿Estás seguro de eliminar esta solicitud?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(false); // No hace nada y cancela
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(true); // Confirma la eliminación
                      _deleteRequest(request.idSolicitud,
                          context); // Llama a la función de eliminación
                    },
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );
          },
          child: GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => DetailRequest(context, request),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: RequestsCards(
                titulo: request.tituloSolicitud,
                administrador: request.nombreAdministrador,
                fecha: request.fechaSolicitud,
                estado: request.estadoSolicitud,
              ),
            ),
          ),
        );
      },
    );
  }
  // Función para eliminar una solicitud
  void _deleteRequest(int idSolicitud, BuildContext context) {
    RequestService().requestDelete(idSolicitud).then((value) {
      if (value == 1) {
        showAlertDialog(
            'Éxito', 'Se ha eliminado la solicitud exitosamente ', 3, context);
      } else {
        showAlertDialog(
            'Error', 'No se ha podido eliminar la solicitud', 2, context);
      }
    });
  }
}
