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

  @override
  void initState() {
    super.initState();
    _loadMessages();
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
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await MessageService().cargarChats();
      if (messages.isEmpty) {
        _showNoConversationsAlert();
      } else {
        setState(() {
          _chatCards.clear(); // Clear existing cards
        });

        for (var message in messages) {
          print(message.senderType);
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
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _refreshMessages() async {
    // Remove all items with animation
    for (int i = _chatCards.length - 1; i >= 0; i--) {
      _listKey.currentState?.removeItem(
        i,
        (context, animation) => _buildAnimatedItem(context, i, animation),
        duration: const Duration(milliseconds: 300),
      );
    }
    await _loadMessages(); // Call the message loading function
  }

  @override
  Widget build(BuildContext context) {
    final Color containerMain = ThemeUtils.getColorBasedOnBrightness(
        context, colorBackGroundMessageContainerLight, almostBlackColor);

    return Scaffold(
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
                    onRefresh: _refreshMessages, // Attach the refresh function
                    child: AnimatedList(
                      key: _listKey,
                      padding: const EdgeInsets.only(top: 35.0),
                      initialItemCount: _chatCards.length,
                      itemBuilder: (context, index, animation) {
                        return _buildAnimatedItem(context, index, animation);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
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
              child: const SearchInput(),
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
}
