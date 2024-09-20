import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_requests.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/detail_request.dart';
import 'package:habbit_mobil_flutter/common/widgets/header_screen.dart';
import 'package:habbit_mobil_flutter/data/controlers/request_controlers.dart';
import 'package:habbit_mobil_flutter/data/models/request_model.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

// Pantalla de solicitudes
class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

// Estado de la pantalla de solicitudes
class _RequestsScreenState extends State<RequestsScreen>
    with SingleTickerProviderStateMixin {
  // Lista de solicitudes
  List<RequestModel> requestsData = [];
  List<RequestModel> filteredRequests = [];
  bool isLoading = true;
  String? errorMessage;
  bool isSearchVisible = false;
  String searchQuery = '';
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  // Método para inicializar el estado
  @override
  void initState() {
    super.initState();
    _loadRequests();
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
  // Método para cargar las solicitudes
  Future<void> _loadRequests() async {
    try {
      setState(() {
        isLoading = true;
      });
      final loadedRequests = await RequestService().cargarRequest();
      setState(() {
        requestsData = loadedRequests;
        filteredRequests = requestsData;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error al cargar solicitudes: $error';
        isLoading = false;
      });
    }
  }
  // Método para alternar la visibilidad de la búsqueda
  void _toggleSearch() {
    setState(() {
      isSearchVisible = !isSearchVisible;
      if (isSearchVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
        setState(() {
          filteredRequests = requestsData;
        });
      }
    });
  }
  // Método para cambiar la consulta de búsqueda
  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      filteredRequests = requestsData
          .where((request) =>
              request.tituloSolicitud.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  // Método para construir la pantalla
  @override
  Widget build(BuildContext context) {
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor);
    // Inicio de la construcción de la pantalla
    return Scaffold(
      backgroundColor: colorBackGroundMessage,
      body: Column(
        children: [
          const SizedBox(height: 20),
          HeaderScreen(
            isSearchVisible: isSearchVisible,
            onSearchToggle: _toggleSearch,
            offsetAnimation: _offsetAnimation,
            onSearchChanged: _onSearchChanged,
            hintTextt: 'Buscar solicitudes...',
            titleHeader: 'Solicitudes',
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: containerMain,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                        ? Center(
                            child: Text(
                              errorMessage!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _loadRequests,
                            child: ListRequest(
                              requestsData: filteredRequests,
                              parentContext: context, // Pasar el context principal
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
      // Botón flotante para agregar una nueva solicitud
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/newRequest');
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
  // Método para liberar recursos
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
// Widget de lista de solicitudes
class ListRequest extends StatelessWidget {
  const ListRequest({super.key, required this.requestsData, required this.parentContext});

  final List<RequestModel> requestsData;
  final BuildContext parentContext;
  // Método para construir la lista de solicitudes
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: requestsData.length,
      itemBuilder: (context, index) {
        final request = requestsData[index];
        return Dismissible(
          key: ValueKey(request.idSolicitud),
          direction: DismissDirection.endToStart,
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
            return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmar'),
                content: const Text('¿Estás seguro de eliminar esta solicitud?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      _deleteRequest(request.idSolicitud, parentContext);
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
  // Método para eliminar una solicitud
  void _deleteRequest(int idSolicitud, BuildContext parentContext) async {
    final bool value = await RequestService().requestDelete(idSolicitud);

    if (value) {
      showAlertDialog('Éxito', 'Se ha eliminado la solicitud exitosamente', 3, parentContext);
    } else {
      showAlertDialog('Error', 'No se ha podido eliminar la solicitud', 2, parentContext);
    }
  }
}
