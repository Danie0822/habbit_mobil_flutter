import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_requests.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/detail_request.dart';
import 'package:habbit_mobil_flutter/common/widgets/header_screen.dart';
import 'package:habbit_mobil_flutter/data/controlers/request_controlers.dart';
import 'package:habbit_mobil_flutter/data/models/request_model.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> with SingleTickerProviderStateMixin {
  // Variables de listas de solicitudes
  List<RequestModel> requestsData = [];
  List<RequestModel> filteredRequests = [];
  // Variables de estado
  bool isLoading = true;
  // Variables de error
  String? errorMessage;
  // Variables de búsqueda
  bool isSearchVisible = false;
  // Variables de busquedas 
  String searchQuery = '';
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
 // Inicializar las solicitudes
  @override
  void initState() {
    super.initState();
    _loadRequests();
    // Inicializar la animación del buscador
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }
  // Cargar las solicitudes
  Future<void> _loadRequests() async {
    try {
      setState(() {
        isLoading = true;
      });
      final loadedRequests = await RequestService().cargarRequest();
      setState(() {
        requestsData = loadedRequests;
        filteredRequests = requestsData; // Inicialmente, todas las solicitudes
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error al cargar solicitudes: $error';
        isLoading = false;
      });
    }
  } 
  // Función para mostrar u ocultar el buscador
  void _toggleSearch() {
    setState(() {
      isSearchVisible = !isSearchVisible;
      if (isSearchVisible) {
        _controller.forward(); // Mostrar el buscador
      } else {
        _controller.reverse(); // Ocultar el buscador
        setState(() {
          filteredRequests = requestsData; // Resetear la lista al cerrar el buscador
        });
      }
    });
  }
  // Función para filtrar las solicitudes
  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      filteredRequests = requestsData
          .where((request) => request.tituloSolicitud
              .toLowerCase()
              .contains(query.toLowerCase())) // Filtrar solicitudes
          .toList();
    });
  }
  // Construir la pantalla de solicitudes el diseño 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          // Encabezado de la pantalla
          HeaderScreen(
            isSearchVisible: isSearchVisible,
            onSearchToggle: _toggleSearch,
            offsetAnimation: _offsetAnimation,
            onSearchChanged: _onSearchChanged,
            hintTextt: 'Buscar solicitudes...',
            titleHeader: 'Solicitudes',
          ),
          // Cuerpo de la pantalla
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(child: Text(errorMessage!))
                    : RefreshIndicator(
                        onRefresh: _loadRequests,
                        child: ListRequest(requestsData: filteredRequests), // Mostrar la lista filtrada
                      ),
          ),
        ],
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
  // Liberar recursos
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
// Clase para mostrar la lista de solicitudes
class ListRequest extends StatelessWidget {
  const ListRequest({super.key, required this.requestsData});

  final List<RequestModel> requestsData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( // Construir la lista de solicitudes
      padding: const EdgeInsets.all(8.0),
      itemCount: requestsData.length,
      itemBuilder: (context, index) {
        final request = requestsData[index];
        // Widget para deslizar y eliminar una solicitud
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
                    request: request,
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
