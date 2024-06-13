import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';


class MessagesScreen extends StatelessWidget {
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
                  child: ListView(
                    padding: const EdgeInsets.only(top: 35.0),
                    children: _buildChatCards(),
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

  List<Widget> _buildChatCards() {
    return const [
      ChatCard(
        name: 'Alessandro Morales',
        message: 'alessandro.morales@gmail.com',
        time: '12:00'
      ),
      ChatCard(
        name: 'Fernando Gomez',
        message: 'Hola, me gustas',
        time: '15:00',
      ),
      ChatCard(
        name: 'Adriana Oreo',
        message: 'Hola, no me gusta la casa',
        time: '15:00',
      ),
      ChatCard(
        name: 'Jose Sanchez',
        message: 'Hola, me gusta braw',
        time: '15:00',
      ),
      ChatCard(
        name: 'Emiliano Jacobo',
        message: 'Holi',
        time: '15:00'
      ),
      ChatCard(
        name: 'Oscar Gomez',
        message: 'Hola, me gustas',
        time: '15:00'
      ),
      ChatCard(
        name: 'Daniel Gomez',
        message: 'Hola, me gustas',
        time: '15:00'
      ),
    ];
  }
}
