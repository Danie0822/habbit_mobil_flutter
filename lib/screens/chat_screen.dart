// ignore_for_file: avoid_print, library_private_types_in_public_api, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/message_widget.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_chat.dart';
import 'package:habbit_mobil_flutter/data/controlers/chat.dart';
import 'package:habbit_mobil_flutter/data/models/read_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

// Definición de la pantalla de chat como un widget con estado
class ChatScreen extends StatefulWidget {
  final int idConversacion;
  final String nameUser;

  // Constructor de ChatScreen
  const ChatScreen({Key? key, required this.idConversacion, required this.nameUser}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

// Estado asociado al widget ChatScreen
class _ChatScreenState extends State<ChatScreen> {
  List<ReadChatResponse> _mensajes = [];  // Lista para almacenar los mensajes
  final ScrollController _scrollController = ScrollController();  // Controlador para la lista de mensajes
  final TextEditingController _messageController = TextEditingController();  // Controlador para el campo de texto del mensaje

  @override
  void initState() {
    super.initState();
    _loadMessages();  // Carga los mensajes cuando se inicializa el estado
  }

  // Método para cargar los mensajes desde el servidor
  Future<void> _loadMessages() async {
    try {
      print('Cargando mensajes para la conversación ID: ${widget.idConversacion}');
      List<ReadChatResponse> mensajes = await ChatService().getClientMessages(widget.idConversacion);
      print('Mensajes cargados: ${mensajes.length}');
      setState(() {
        _mensajes = mensajes;  // Actualiza el estado con los mensajes cargados
      });
      _updateReadStatus();  // Actualiza el estado de lectura de los mensajes
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());  // Desplaza la lista de mensajes hacia el final
    } catch (e) {
      print('Error cargando mensajes: $e');
    }
  }

  // Método para actualizar el estado de lectura del último mensaje si es necesario
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
            ultimoMensaje.updateReadStatus(true);  // Actualiza el estado del mensaje a leído
          });
        } else {
          print('Error al actualizar el estado de leído.');
        }
      }
    }
  }

  // Método para desplazar la lista de mensajes hacia el final
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

  // Método para enviar un mensaje
  Future<void> _sendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    bool success = await ChatService().sendMessage(widget.idConversacion, messageText);
    if (success) {
      _loadMessages();  // Recarga los mensajes después de enviar uno nuevo
      _messageController.clear();  // Limpia el campo de texto
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());  // Desplaza la lista de mensajes hacia el final
    } else {
      print('Error al enviar el mensaje');
    }
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
            context.push('/main', extra: 2);  // Navega hacia la pantalla principal al presionar el botón de retroceso
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Lista de mensajes
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
            // Campo de texto para enviar mensajes
            MyTextField(
              controller: _messageController,
              hint: 'Escribe un mensaje...',
              isPassword: false,
              icon: Icons.message,
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,  // Envía el mensaje al presionar el botón de enviar
              ),
            ),
          ],
        ),
      ),
    );
  }
}
