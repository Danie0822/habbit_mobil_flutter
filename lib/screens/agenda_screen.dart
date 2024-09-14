import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/card_visit.dart';
import 'package:habbit_mobil_flutter/common/widgets/detail_agenda.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';
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
    with TickerProviderStateMixin {
  List<VisitModel> visitData = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_ES', null).then((_) {
      _loadVisits(); // Cargar las visitas después de inicializar la localización
    });
  }

  // Función para cargar las visitas
  Future<void> _loadVisits() async {
    try {
      setState(() {
        isLoading = true;
      });
      final loadedVisits = await VisitControler().cargarVisitas();
      setState(() {
        visitData = loadedVisits;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error al cargar visitas: $error';
        isLoading = false;
      });
    }
  }

  // Función para refrescar las visitas
  Future<void> _refreshVisits() async {
    await _loadVisits();
  }

  // Función para formatear la fecha
  String formatFecha(DateTime fecha) {
    return DateFormat('d \'de\' MMMM \'de\' yyyy, h:mm a', 'es_ES')
        .format(fecha.toLocal());
  }

  // Función para eliminar una visita
  void _deleteVisit(int idVisita, BuildContext context) {
    VisitControler().visitUpdate(idVisita).then((value) {
      if (value == true) {
        showAlertDialog(
          'Éxito', 'Se ha eliminado el evento de tu listado exitosamente', 3 , context
        );
        _refreshVisits(); // Refrescar la lista después de eliminar
      } else {
        showAlertDialog(
          'Error', 'No se ha podido eliminar el evento de tu listado', 2, context
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(), // Construir encabezado
            Expanded(
              child: Container(
                color: Colors.white, // Fondo blanco para la lista
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                        ? Center(child: Text(errorMessage!))
                        : visitData.isEmpty
                            ? const Center(
                                child: Text('No hay eventos disponibles.'))
                            : RefreshIndicator(
                                onRefresh: _refreshVisits,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(16.0),
                                  itemCount: visitData.length,
                                  itemBuilder: (context, index) {
                                    final visit = visitData[index];
                                    return Dismissible(
                                      key: ValueKey(visit.IdVisita),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      confirmDismiss: (direction) async {
                                        // Confirmar la acción de eliminar
                                        return await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Confirmar'),
                                            content: const Text(
                                                '¿Estás seguro de eliminar este evento?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(
                                                      false); // Cancela la eliminación
                                                },
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(
                                                      true); // Confirma la eliminación
                                                  _deleteVisit(
                                                      visit.IdVisita,
                                                      context); // Llama a la función de eliminación
                                                },
                                                child: const Text('Eliminar'),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      onDismissed: (direction) {
                                        // Acción después de eliminar
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                DetailAgenda(context, visit),
                                          );
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          elevation: 2,
                                          child: EventCard(
                                            titulo: visit.tituloVisita,
                                            estado: visit.estadoVisita,
                                            fecha_inicio: formatFecha(
                                                visit.fechaHoraInicio),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construir encabezado azul
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      color: primaryColor, // Color azul para el encabezado
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Tus eventos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Acción de búsqueda aquí
            },
          ),
        ],
      ),
    );
  }
}
