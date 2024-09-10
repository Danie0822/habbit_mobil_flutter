import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/message_widget.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_chat.dart';
import 'package:habbit_mobil_flutter/data/controlers/chat.dart';
import 'package:habbit_mobil_flutter/data/models/read_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';
import 'package:habbit_mobil_flutter/utils/theme/theme_utils.dart';

class ChatScreen extends StatefulWidget {
  final int idConversacion;
  final String nameUser;

  const ChatScreen(
      {Key? key, required this.idConversacion, required this.nameUser})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ReadChatResponse> _mensajes = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  List<String> sugerencias = [
    '¿Cuál es la dirección exacta del inmueble?',
    '¿Cuántos años tiene la propiedad?',
    '¿Cuál es el área total construida?',
    '¿Cuántas habitaciones y baños tiene la propiedad?',
    '¿La propiedad cuenta con estacionamiento? ¿Cuántos autos caben?',
    '¿Está la propiedad sujeta a algún gravamen o hipoteca?',
    '¿Hay algún tipo de servicio de seguridad en la zona o en el edificio?',
    '¿Cómo es la distribución interna del inmueble?',
    '¿El inmueble cuenta con servicios básicos como agua, electricidad y gas?',
    '¿Hay algún tipo de mantenimiento pendiente en la propiedad?',
    '¿Cuál es el costo de las tasas municipales o impuestos asociados a la propiedad?',
    '¿Cuál es el historial de ocupación de la propiedad? ¿Ha estado desocupada por mucho tiempo?',
    '¿Cuál es el costo aproximado de los servicios públicos (agua, luz, gas)?',
    '¿Se permiten modificaciones o renovaciones en la propiedad?',
    '¿Hay algún tipo de restricción o reglamento de condominio?',
    '¿Cuáles son las condiciones del vecindario en cuanto a seguridad y servicios?',
    '¿La propiedad ha sido renovada recientemente?',
    '¿Cuál es la orientación de la propiedad y cómo afecta la luz natural?',
    '¿Hay escuelas, hospitales o centros comerciales cercanos?',
    '¿Cuál es el costo aproximado del seguro de la propiedad?',
  ];

  List<String> sugerenciasActuales = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _seleccionarSugerenciasAleatorias(); // Selecciona sugerencias al iniciar
  }

  Future<void> _loadMessages() async {
    try {
      print(
          'Cargando mensajes para la conversación ID: ${widget.idConversacion}');
      List<ReadChatResponse> mensajes =
          await ChatService().getClientMessages(widget.idConversacion);
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
          bool success = await ChatService()
              .updateMessageReadStatus(widget.idConversacion);
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

  Future<void> _sendMessage(String messageText) async {
    try {
      if (messageText.isEmpty) return;

      bool success =
          await ChatService().sendMessage(widget.idConversacion, messageText);
      if (success) {
        _loadMessages();
        _messageController.clear();
        _seleccionarSugerenciasAleatorias(); // Cambia sugerencias al enviar mensaje
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

  void _handleSuggestionTap(String suggestion) {
    _messageController.text = suggestion;
  }

  void _seleccionarSugerenciasAleatorias() {
    setState(() {
      sugerenciasActuales = List<String>.from(sugerencias)
        ..shuffle(); // Mezcla las sugerencias
      sugerenciasActuales =
          sugerenciasActuales.take(4).toList(); // Toma las primeras 4
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasMessages = _mensajes.isNotEmpty;

    // Define el color basado en el tema (brillo de la pantalla)
    final Color colorTextoTitulo =
        Theme.of(context).brightness == Brightness.light
            ? const Color(0xFF06065E) // Color para modo claro
            : ThemeUtils.getColorBasedOnBrightness(
                context, Colors.white, Colors.grey);

    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.nameUser, style: const TextStyle(color: Colors.white)),
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
            if (!hasMessages)
              Container(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: sugerenciasActuales
                      .map((sugerencia) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => _handleSuggestionTap(sugerencia),
                              child: Text(
                                sugerencia,
                                style: TextStyle(
                                  color: colorTextoTitulo, // Cambia este color por el que desees
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            MyTextField(
              controller: _messageController,
              hint: 'Escribe un mensaje...',
              isPassword: false,
              icon: Icons.message,
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _sendMessage(_messageController.text.trim()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
