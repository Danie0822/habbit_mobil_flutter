// ignore_for_file: avoid_print

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

  const ChatScreen({Key? key, required this.idConversacion, required this.nameUser}) : super(key: key);

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
      _showErrorSnackBar('Error al cargar mensajes.');
    }
  }

  Future<void> _updateReadStatus() async {
    try {
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
            _showErrorSnackBar('Error al actualizar estado de leído.');
          }
        }
      }
    } catch (e) {
      print('Error actualizando estado de lectura: $e');
      _showErrorSnackBar('Error al actualizar estado de lectura.');
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    try {
      String messageText = _messageController.text.trim();
      if (messageText.isEmpty) return;

      bool success = await ChatService().sendMessage(widget.idConversacion, messageText);
      if (success) {
        _loadMessages();
        _messageController.clear();
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      } else {
        print('Error al enviar el mensaje');
        _showErrorSnackBar('Error al enviar el mensaje.');
      }
    } catch (e) {
      print('Error enviando mensaje: $e');
      _showErrorSnackBar('Error al enviar el mensaje.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nameUser, style: const TextStyle(color: Colors.white)),
        backgroundColor: colorBackGroundMessage,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/main', extra: 2);
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
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
