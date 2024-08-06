// ignore_for_file: deprecated_member_use, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/constants/config.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/data/controlers/message.dart';
import 'package:habbit_mobil_flutter/common/widgets/search_input.dart';
import 'package:habbit_mobil_flutter/common/widgets/custom_alert.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with TickerProviderStateMixin {
  final List<ChatCard> _chatCards = []; // Lista de tarjetas de chat
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>(); // Llave para la lista animada
  bool _isSearchVisible = false; // Estado de visibilidad del campo de búsqueda
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  ); // Controlador de animación para el campo de búsqueda
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  )); // Animación de desplazamiento para el campo de búsqueda
  String _searchQuery = ''; // Consulta de búsqueda actual

  @override
  void initState() {
    super.initState();
    _loadMessages(); // Carga los mensajes al inicializar
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await MessageService().cargarChats(); // Cargar mensajes desde el servicio
      if (messages.isEmpty) {
        _showNoConversationsAlert(); // Muestra alerta si no hay conversaciones
      } else {
        setState(() {
          _chatCards.clear();
          for (var message in messages) {
            _chatCards.add(ChatCard(
              idConversacion: message.conversacionId ?? 0,
              title: message.propertyTitle ?? 'Sin título',
              name: message.adminName ?? 'Sin nombre',
              message: message.lastMessage ?? 'Sin mensaje',
              time: message.time ?? '15:00',
              imageUrl: message.imageUrl != null ? '${Config.imagen}${message.imageUrl}' : '',
              isRead: message.readMessage ?? false,
              isAdmin: message.senderType == 'Administrador',
            ));
            _listKey.currentState?.insertItem(_chatCards.length - 1); // Inserta el nuevo elemento en la lista animada
          }
        });
      }
    } catch (e) {
      print('Error cargando chats: $e'); // Manejo de errores al cargar mensajes
    }
  }

  void _showNoConversationsAlert() {
    showAlertDialog(
      'Sin conversaciones',
      'No has iniciado ninguna conversación todavía.',
      1,
      context,
    ); // Muestra alerta si no hay conversaciones
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible; // Alterna la visibilidad del campo de búsqueda
      if (_isSearchVisible) {
        _controller.forward(); // Muestra el campo de búsqueda con animación
      } else {
        _controller.reverse(); // Oculta el campo de búsqueda con animación
        _searchQuery = '';
        _refreshMessages(); // Refresca los mensajes al ocultar el campo de búsqueda
      }
    });
  }

  void _filterMessages(String query) {
    setState(() {
      _searchQuery = query.toLowerCase(); // Actualiza la consulta de búsqueda
    });
  }

  Future<void> _refreshMessages() async {
    for (int i = _chatCards.length - 1; i >= 0; i--) {
      _listKey.currentState?.removeItem(
        i,
        (context, animation) => _buildAnimatedItem(context, i, animation),
        duration: const Duration(milliseconds: 300),
      ); // Elimina elementos de la lista animada
    }
    await _loadMessages(); // Recarga los mensajes
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera el controlador de animación
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor); // Obtiene el color basado en el tema

    return WillPopScope(
      onWillPop: () async {
        await _loadMessages(); // Recarga mensajes al regresar
        return true;
      },
      child: Scaffold(
        backgroundColor: colorBackGroundMessage,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(), // Construye la cabecera de la pantalla
              const SizedBox(height: 20.0),
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
                      onRefresh: _refreshMessages, // Actualiza los mensajes al hacer pull-to-refresh
                      child: AnimatedList(
                        key: _listKey,
                        padding: const EdgeInsets.only(top: 35.0),
                        initialItemCount: _chatCards.length,
                        itemBuilder: (context, index, animation) {
                          return _buildFilteredItem(context, index, animation); // Construye los elementos de la lista filtrados
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mensajes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: whiteColor,
                ),
              ),
              IconButton(
                onPressed: _toggleSearch, // Alterna la visibilidad del campo de búsqueda
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: child.key == const ValueKey('search') ? animation : Tween<double>(begin: 1, end: 0.75).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    ); // Transición animada para el ícono de búsqueda
                  },
                  child: Icon(
                    _isSearchVisible ? Icons.close : Icons.search,
                    key: ValueKey(_isSearchVisible ? 'close' : 'search'),
                    color: whiteColor,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
          if (_isSearchVisible)
            SlideTransition(
              position: _offsetAnimation, // Animación de deslizamiento para el campo de búsqueda
              child: SearchInput(
                onChanged: _filterMessages, // Filtra los mensajes según la consulta de búsqueda
                hintText: 'Buscar por título...',
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem(BuildContext context, int index, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation), // Transición de deslizamiento para las tarjetas de chat
        child: _chatCards[index], // Construye la tarjeta de chat
      ),
    );
  }

  Widget _buildFilteredItem(BuildContext context, int index, Animation<double> animation) {
    if (_searchQuery.isEmpty || _chatCards[index].title.toLowerCase().contains(_searchQuery)) {
      return _buildAnimatedItem(context, index, animation); // Muestra las tarjetas filtradas
    } else {
      return Container(); // Oculta el elemento si no coincide con la búsqueda
    }
  }
}
