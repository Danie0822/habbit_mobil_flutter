// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<ChatCard> _chatCards = const [
    ChatCard(name: 'Alessandro Morales', message: 'alessandro.morales@gmail.com', time: '12:00'),
    ChatCard(name: 'Fernando Gomez', message: 'Hola, me gustas', time: '15:00'),
    ChatCard(name: 'Adriana Oreo', message: 'Hola, no me gusta la casa', time: '15:00'),
    ChatCard(name: 'Jose Sanchez', message: 'Hola, me gusta braw', time: '15:00'),
    ChatCard(name: 'Emiliano Jacobo', message: 'Holi', time: '15:00'),
    ChatCard(name: 'Oscar Gomez', message: 'Hola, me gustas', time: '15:00'),
    ChatCard(name: 'Daniel Gomez', message: 'Hola, me gustas', time: '15:00'),
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _addChatCards();
  }

  void _addChatCards() async {
    for (int i = 0; i < _chatCards.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
    }
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
                  child: AnimatedList(
                    key: _listKey,
                    padding: const EdgeInsets.only(top: 35.0),
                    initialItemCount: 0,
                    itemBuilder: (context, index, animation) {
                      return _buildAnimatedItem(context, index, animation);
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
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
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: whiteColor,
            iconSize: 35.0,
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
          begin: const Offset(-1, 0), // Cambia aquí el offset inicial para que venga de la izquierda
          end: Offset.zero,
        ).animate(animation),
        child: chatCard,
      ),
    );
  }
}
