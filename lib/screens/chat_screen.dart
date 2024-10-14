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
  // Lista de sugerencias para mensajes
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
    // Carga los mensajes al iniciar
    _loadMessages();
    // Selecciona sugerencias al iniciar
    _seleccionarSugerenciasAleatorias();
  }

  Future<void> _loadMessages() async {
    try {
      // Carga los mensajes del chat
      List<ReadChatResponse> mensajes =
          await ChatService().getClientMessages(widget.idConversacion);
          // Actualiza el estado de los mensajes
      setState(() {
        _mensajes = mensajes;
      });
      // Actualiza el estado de lectura
      _updateReadStatus();
      // Desplaza la pantalla hacia abajo
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      _showErrorSnackBar('Error al cargar mensajes.');
    }
  }
  // Método para actualizar el estado de lectura
  Future<void> _updateReadStatus() async {
    try {
      // Verifica si hay mensajes
      if (_mensajes.isNotEmpty) {
        // Obtiene el último mensaje
        final ultimoMensaje = _mensajes.last;
        // Verifica si el mensaje fue enviado por el administrador
        bool isSentByAdmin = ultimoMensaje.mensajeAdmin != null;
        // Verifica si el mensaje fue leído
        bool isRead = ultimoMensaje.readMessage ?? false;
        // Verifica si el mensaje fue enviado por el administrador y no ha sido leído
        if (isSentByAdmin && !isRead) {
          // Actualiza el estado de lectura
          bool success = await ChatService()
              .updateMessageReadStatus(widget.idConversacion);
          if (success) {
            // Actualiza el estado de lectura
            setState(() {
              ultimoMensaje.updateReadStatus(true);
            });
          } else {
            _showErrorSnackBar('Error al actualizar estado de leído.');
          }
        }
      }
    } catch (e) {
      _showErrorSnackBar('Error al actualizar estado de lectura.');
    }
  }
  // Método para desplazar la pantalla hacia abajo
  void _scrollToBottom() {
    /// Verifica si el controlador de desplazamiento tiene clientes
    if (_scrollController.hasClients) {
      // Desplaza la pantalla hacia abajo
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      // Anima el desplazamiento
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }
  // Método para enviar un mensaje
  Future<void> _sendMessage(String messageText) async {
    try {
      // Verifica si el mensaje está vacío
      if (messageText.isEmpty) return;
      // Envía el mensaje
      bool success =
          await ChatService().sendMessage(widget.idConversacion, messageText);
      if (success) {
        //  Carga los mensajes
        _loadMessages();
        // Limpia el controlador de mensajes
        _messageController.clear();
        // Cambia sugerencias al enviar mensaje
        _seleccionarSugerenciasAleatorias(); 
        // Desplaza la pantalla hacia abajo
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      } else {
        _showErrorSnackBar('Error al enviar el mensaje.');
      }
    } catch (e) {
      _showErrorSnackBar('Error al enviar el mensaje.');
    }
  }
  // Método para mostrar un mensaje de error
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  // Método para manejar el toque de sugerencias
  void _handleSuggestionTap(String suggestion) {
    _messageController.text = suggestion;
  }
  // Método para seleccionar sugerencias aleatorias
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
    // Verifica si hay mensajes
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
            // Muestra sugerencias si no hay mensajes
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
                                  color: colorTextoTitulo, 
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
