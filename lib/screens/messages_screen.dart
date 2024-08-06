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
  final List<ChatCard> _chatCards = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _isSearchVisible = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _loadMessages();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMessages();
  }

  @override
  void didUpdateWidget(covariant MessagesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await MessageService().cargarChats();
      if (messages.isEmpty) {
        _showNoConversationsAlert();
      } else {
        setState(() {
          _chatCards.clear();
        });

        for (var message in messages) {
          final chatCard = ChatCard(
            idConversacion: message.conversacionId ?? 0,
            title: message.propertyTitle ?? 'Sin título',
            name: message.adminName ?? 'Sin nombre',
            message: message.lastMessage ?? 'Sin mensaje',
            time: message.time ?? '15:00',
            imageUrl: message.imageUrl != null ? '${Config.imagen}${message.imageUrl}' : '',
            isRead: message.readMessage ?? false,
            isAdmin: message.senderType == 'Administrador',
          );

          setState(() {
            _chatCards.add(chatCard);
            _listKey.currentState?.insertItem(_chatCards.length - 1);
          });
        }
      }
    } catch (e) {
      print('Error cargando chats: $e');
    }
  }

  void _showNoConversationsAlert() {
    showAlertDialog(
      'Sin conversaciones',
      'No has iniciado ninguna conversación todavía.',
      1,
      context,
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
      if (_isSearchVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
        _searchQuery = '';
        _refreshMessages();
      }
    });
  }

  void _filterMessages(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _refreshMessages() async {
    for (int i = _chatCards.length - 1; i >= 0; i--) {
      _listKey.currentState?.removeItem(
        i,
        (context, animation) => _buildAnimatedItem(context, i, animation),
        duration: const Duration(milliseconds: 300),
      );
    }
    await _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor);

    return WillPopScope(
      onWillPop: () async {
        await _loadMessages(); // Recargar mensajes al regresar
        return true;
      },
      child: Scaffold(
        backgroundColor: colorBackGroundMessage,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
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
                      onRefresh: _refreshMessages,
                      child: AnimatedList(
                        key: _listKey,
                        padding: const EdgeInsets.only(top: 35.0),
                        initialItemCount: _chatCards.length,
                        itemBuilder: (context, index, animation) {
                          return _buildFilteredItem(context, index, animation);
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
                onPressed: _toggleSearch,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: child.key == ValueKey('search') ? animation : Tween<double>(begin: 1, end: 0.75).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
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
              position: _offsetAnimation,
              child: SearchInput(
                onChanged: _filterMessages,
                hintText: 'Buscar por título...',
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem(BuildContext context, int index, Animation<double> animation) {
    final chatCard = _chatCards[index];
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: chatCard,
      ),
    );
  }

  Widget _buildFilteredItem(BuildContext context, int index, Animation<double> animation) {
    if (_searchQuery.isEmpty) {
      return _buildAnimatedItem(context, index, animation);
    }
    final chatCard = _chatCards[index];
    if (chatCard.title.toLowerCase().contains(_searchQuery)) {
      return _buildAnimatedItem(context, index, animation);
    } else {
      return Container(); // Oculta el elemento si no coincide con la búsqueda
    }
  }
}
