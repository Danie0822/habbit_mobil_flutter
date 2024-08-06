import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/message_widget.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_chat.dart';
import 'package:habbit_mobil_flutter/data/controlers/chat.dart';
import 'package:habbit_mobil_flutter/data/models/read_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

class ChatScreen extends StatefulWidget {
  final int idConversacion;
  final String nameUser;

  ChatScreen({required this.idConversacion, required this.nameUser});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ReadChatResponse> _mensajes = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      print('Cargando mensajes para la conversación ID: ${widget.idConversacion}');
      List<ReadChatResponse> mensajes = await ChatService().getClientMessages(widget.idConversacion);
      print('Mensajes cargados: ${mensajes.length}');
      setState(() {
        _mensajes = mensajes;
      });
      _updateReadStatus();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      print('Error cargando mensajes: $e');
    }
  }

  Future<void> _updateReadStatus() async {
    if (_mensajes.isNotEmpty) {
      final ultimoMensaje = _mensajes.last;
      bool isSentByAdmin = ultimoMensaje.mensajeAdmin != null;
      bool isRead = ultimoMensaje.readMessage ?? false;

      if (isSentByAdmin && !isRead) {
        bool success = await ChatService().updateMessageReadStatus(widget.idConversacion);
        if (success) {
          print('Estado de leído actualizado exitosamente.');
          setState(() {
            ultimoMensaje.updateReadStatus(true);
          });
        } else {
          print('Error al actualizar el estado de leído.');
        }
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    bool success = await ChatService().sendMessage(widget.idConversacion, messageText);
    if (success) {
      setState(() {
        _loadMessages();
      });
      _messageController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } else {
      print('Error al enviar el mensaje');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nameUser, style: TextStyle(color: Colors.white)),
        backgroundColor: colorBackGroundMessage,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadMessages,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _mensajes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final mensaje = _mensajes[index];
                    bool isSentByAdmin = mensaje.mensajeAdmin != null;
                    String displayedMessage = isSentByAdmin
                        ? mensaje.mensajeAdmin!
                        : mensaje.mensajeCliente ?? "Mensaje no disponible";

                    return MessageWidget(
                      message: displayedMessage,
                      isSentByMe: !isSentByAdmin,
                      readMessage: mensaje.readMessage ?? false,
                      time: mensaje.time ?? '',
                    );
                  },
                ),
              ),
            ),
            MyTextField(
              controller: _messageController,
              hint: 'Escribe un mensaje...',
              isPassword: false,
              icon: Icons.message,
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
