import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_visit.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
import 'package:habbit_mobil_flutter/common/widgets/detail_agenda.dart';
import 'package:habbit_mobil_flutter/common/widgets/header_screen.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/data/controlers/visits.dart';
import 'package:habbit_mobil_flutter/data/models/visits_model.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class VisitScreen extends StatefulWidget {
  const VisitScreen({super.key});

  @override
  State<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen>
    with SingleTickerProviderStateMixin {
  // Variables de listas de visitas
  List<VisitModel> visitData = [];
  List<VisitModel> filteredVisits = [];
  // Variables de estado
  bool isLoading = true;
  // Variables de error
  String? errorMessage;
  // Variables de búsqueda
  bool isSearchVisible = false;
  // Variables de búsqueda
  String searchQuery = '';
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null).then((_) {
      _loadVisits(); // Cargar las visitas después de inicializar la localización
    });
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

  // Cargar las visitas
  Future<void> _loadVisits() async {
    try {
      setState(() {
        isLoading = true;
      });
      final loadedVisits = await VisitControler().cargarVisitas();
      setState(() {
        visitData = loadedVisits;
        filteredVisits = visitData; // Inicialmente, todas las visitas
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error al cargar visitas: $error';
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
          filteredVisits = visitData; // Resetear la lista al cerrar el buscador
        });
      }
    });
  }

  // Función para filtrar las visitas
  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      filteredVisits = visitData
          .where((visit) => visit.tituloVisita
              .toLowerCase()
              .contains(query.toLowerCase())) // Filtrar visitas
          .toList();
    });
  }

  // Construir la pantalla de visitas
  @override
  Widget build(BuildContext context) {
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const SizedBox(height: 40),
          // Encabezado de la pantalla
          HeaderScreen(
            isSearchVisible: isSearchVisible,
            onSearchToggle: _toggleSearch,
            offsetAnimation: _offsetAnimation,
            onSearchChanged: _onSearchChanged,
            hintTextt: 'Buscar eventos...',
            titleHeader: 'Eventos',
          ),
          // Cuerpo de la pantalla
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
                child: RefreshIndicator(
                  onRefresh: _loadVisits,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : errorMessage != null
                          ? Center(child: Text(errorMessage!))
                          : filteredVisits.isEmpty
                              ? const Center(
                                  child: Text('No hay eventos disponibles.'))
                              : ListVisits(
                                  visitsData: filteredVisits,
                                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Clase para mostrar la lista de visitas
class ListVisits extends StatelessWidget {
  const ListVisits({super.key, required this.visitsData});

  final List<VisitModel> visitsData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: visitsData.length,
      itemBuilder: (context, index) {
        final visit = visitsData[index];
        return Dismissible(
          key: ValueKey(visit.IdVisita),
          direction:
              DismissDirection.endToStart, // Permite deslizar para eliminar
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
                content: const Text('¿Estás seguro de eliminar este evento?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(false); // Cancela la eliminación
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(true); // Confirma la eliminación
                      _deleteVisit(visit.IdVisita,
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
              builder: (context) => DetailAgenda(context, visit),
            ),
            child: EventCard(
              titulo: visit.tituloVisita,
              estado: visit.estadoVisita,
              fecha_inicio: formatFecha(visit.fechaHoraInicio),
            ),
          ),
        );
      },
    );
  }

  // Función para eliminar una visita
  void _deleteVisit(int idVisita, BuildContext context) {
    VisitControler().visitUpdate(idVisita).then((value) {
      if (value == true) {
        showAlertDialog(
            'Éxito', 'Se ha eliminado el evento exitosamente', 3, context);
      } else {
        showAlertDialog(
            'Error', 'No se ha podido eliminar el evento', 2, context);
      }
    });
  }

  // Formatear la fecha
  String formatFecha(DateTime fecha) {
    return DateFormat('d \'de\' MMMM \'de\' yyyy, h:mm a', 'es_ES')
        .format(fecha.toLocal());
  }
}
