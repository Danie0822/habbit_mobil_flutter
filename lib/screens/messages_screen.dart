import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/cards_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';
import 'package:habbit_mobil_flutter/common/widgets/search_input.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with TickerProviderStateMixin {
  final List<ChatCard> _chatCards = const [
    ChatCard(
      title: 'Villa San Salvador',
      name: 'Alessandro Morales',
      message: 'Hola, esta propiedad esta en oferta',
      time: '12:00',
      imageUrl: 'assets/images/house_01.jpg',
    ),
    ChatCard(
      title: 'Casa Santa Tecla',
      name: 'Fernando Gomez',
      message: 'Hola, la casa esta ubicada en Cabañas',
      time: 'Lunes',
      imageUrl: 'assets/images/house_04.jpg',
    ),
    ChatCard(
      title: 'Casa Libertad',
      name: 'Adriana Oreo',
      message: 'Hola, esa casa esta alquilada, no ves',
      time: '15/06/2024',
      imageUrl: 'assets/images/house_02.jpg',
    ),
    ChatCard(
      title: 'Casa San Miguel',
      name: 'Jose Sanchez',
      message: 'Hola, Este casa esta en venta',
      time: '15:00',
      imageUrl: 'assets/images/house_03.jpg',
    ),
    ChatCard(
      title: 'Casa Aventura',
      name: 'Emiliano Jacobo',
      message: 'Hola, te gustaria hacer una cita',
      time: '15:00',
      imageUrl: 'assets/images/house_05.jpg',
    ),
    ChatCard(
      title: 'Casa Norte',
      name: 'Oscar Gomez',
      message: 'Hola, si ese dia se puede',
      time: '15:00',
      imageUrl: 'assets/images/house_06.jpg',
    ),
    ChatCard(
      title: 'Residencia Rasmus',
      name: 'Daniel Gomez',
      message: 'Hola, el martes se puede',
      time: '15:00',
      imageUrl: 'assets/images/house_07.jpg',
    ),
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _isSearchVisible = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _addChatCards();
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

  void _addChatCards() async {
    for (int i = 0; i < _chatCards.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      _listKey.currentState?.insertItem(i);
    }
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
