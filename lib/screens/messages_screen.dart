import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/data/controlers/message.dart';
import 'package:habbit_mobil_flutter/common/widgets/header_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with TickerProviderStateMixin {
  // Lista de tarjetas de chat
  final List<ChatCard> _chatCards = []; 
  // Clave para la lista animada
  final GlobalKey<AnimatedListState> _listKey =
      GlobalKey<AnimatedListState>(); 
  // Estado de visibilidad de la búsqueda
  bool _isSearchVisible = false; 
  // Estado de carga
  bool _isLoading = true; 
  /// Controlador de animación
  late final AnimationController _controller; 
  // Animación de desplazamiento
  late final Animation<Offset> _offsetAnimation;
  // Consulta de búsqueda
  String _searchQuery = ''; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _loadMessages(); // Cargar mensajes al inicializar
  }

  // Método para cargar mensajes
  Future<void> _loadMessages() async {
    try {
      final messages = await MessageService()
          .cargarChats(); // Cargar mensajes desde el servicio
      setState(() {
        _chatCards
            .clear(); // Limpiar la lista de tarjetas antes de agregar nuevas
      });
      if (messages.isNotEmpty) {
        for (var message in messages) {
          _chatCards.add(ChatCard(
            idConversacion: message.conversacionId ?? 0,
            title: message.propertyTitle ?? 'Sin título',
            name: message.adminName ?? 'Sin nombre',
            message: message.lastMessage ?? 'Sin mensaje',
            time: message.time ?? '15:00',
            imageUrl: message.imageUrl != null
                ? '${Config.imagen}${message.imageUrl}'
                : '',
            isRead: message.readMessage ?? false,
            isAdmin: message.senderType == 'Administrador',
          ));
        }
        for (int i = 0; i < _chatCards.length; i++) {
          _listKey.currentState
              ?.insertItem(i); // Insertar elementos en la lista animada
        }
      }
    } catch (e) {
      print('Error cargando chats: $e'); // Manejo de errores
    } finally {
      if (!mounted) {
        return; // Evitar llamar a setState si el widget no está montado
      }
      setState(() {
        _isLoading = false; // Cambiar el estado de carga
      });
    }
  }

  // Método para alternar la visibilidad de la búsqueda
  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (_isSearchVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
        _searchQuery = '';
        _refreshMessages(); // Refrescar mensajes al cerrar la búsqueda
      }
    });
  }

  // Método para filtrar mensajes según la consulta de búsqueda
  void _filterMessages(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  // Método para refrescar los mensajes
  Future<void> _refreshMessages() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<Future> futures = [];
      for (int i = _chatCards.length - 1; i >= 0; i--) {
        futures.add(
          Future.delayed(const Duration(milliseconds: 100), () {
            _listKey.currentState?.removeItem(
              i,
              (context, animation) => _buildAnimatedItem(context, i, animation),
              duration: const Duration(milliseconds: 600),
            );
          }),
        );
      }
      await Future.wait(
          futures); // Esperar a que todas las tarjetas sean removidas
      setState(() {
        _chatCards.clear();
      });
      await _loadMessages(); // Cargar mensajes nuevamente
    } catch (e) {
      print('Error refrescando mensajes: $e'); // Manejo de errores
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor);

    return WillPopScope(
      onWillPop: () async {
        await _loadMessages(); // Cargar mensajes al salir
        return true;
      },
      child: Scaffold(
        backgroundColor: colorBackGroundMessage,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderScreen(
                isSearchVisible: _isSearchVisible,
                onSearchToggle: _toggleSearch,
                offsetAnimation: _offsetAnimation,
                onSearchChanged: _filterMessages,
                hintTextt: 'Buscar por titulo de propiedad..',
                titleHeader: 'Mensajes',
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
                    child: RefreshIndicator(
                      onRefresh:
                          _refreshMessages, // Refrescar mensajes al arrastrar hacia abajo
                      child: _isLoading
                          ? const Center(
                              child:
                                  CircularProgressIndicator()) // Mostrar indicador de carga
                          : _chatCards.isEmpty
                              ? const Center(
                                  child: Text(
                                      'No has iniciado ninguna conversación todavía.')) // Mostrar mensaje si no hay conversaciones
                              : AnimatedList(
                                  key: _listKey,
                                  padding: const EdgeInsets.only(top: 35.0),
                                  initialItemCount: _chatCards.length,
                                  itemBuilder: (context, index, animation) {
                                    return _buildFilteredItem(context, index,
                                        animation); // Construir elemento filtrado
                                  },
                                ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Construir elemento animado
  Widget _buildAnimatedItem(
      BuildContext context, int index, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: _chatCards[index],
      ),
    );
  }

  // Construir elemento filtrado
  Widget _buildFilteredItem(
      BuildContext context, int index, Animation<double> animation) {
    if (_searchQuery.isEmpty ||
        _chatCards[index].title.toLowerCase().contains(_searchQuery)) {
      return _buildAnimatedItem(context, index, animation);
    } else {
      return Container();
    }
  }
}
