import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habbit_mobil_flutter/common/widgets/message_widget.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_chat.dart';
import 'package:habbit_mobil_flutter/utils/constants/colors.dart';

// Definición de la clase ChatScreen como un StatefulWidget
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

// Estado asociado a ChatScreen
class _ChatScreenState extends State<ChatScreen> {
  // Lista de mensajes en el chat
  final List<Map<String, dynamic>> mensajes = [
    {"mensaje": "Hola, ¿cómo estás?", "isSentByMe": true},
    {"mensaje": "Bien, ¿y tú?", "isSentByMe": false},
    {
      "mensaje":
          "Muy bien, gracias por preguntar. Estoy interesado en comprar una casa y quisiera hacer una cita para verla.",
      "isSentByMe": true
    },
    {
      "mensaje":
          "¡Claro! Estaré encantado de ayudarte. ¿Tienes alguna casa en particular que te interese?",
      "isSentByMe": false
    },
    {
      "mensaje":
          "Sí, me interesa la casa que vi en su sitio web en la Calle Elm. ¿Está disponible para una visita?",
      "isSentByMe": true
    },
    {
      "mensaje":
          "Sí, la casa en la Calle Elm está disponible para visitas. ¿Cuál sería un buen momento para ti?",
      "isSentByMe": false
    },
    {
      "mensaje":
          "Podría el viernes por la tarde, alrededor de las 3 PM. ¿Ese horario les conviene?",
      "isSentByMe": true
    },
    {
      "mensaje":
          "Perfecto, podemos programar la visita para el viernes a las 3 PM. ¿Te gustaría que te enviemos más detalles sobre la propiedad antes de la cita?",
      "isSentByMe": false
    },
    {
      "mensaje":
          "Sí, por favor, me gustaría recibir más información sobre la casa, especialmente sobre el vecindario y las escuelas cercanas.",
      "isSentByMe": true
    },
    {
      "mensaje":
          "Con mucho gusto, te enviaré toda la información por correo electrónico. ¿Hay algo más que te gustaría saber antes de la visita?",
      "isSentByMe": false
    },
    {
      "mensaje":
          "No, eso sería todo por ahora. Gracias por la ayuda y nos vemos el viernes.",
      "isSentByMe": true
    },
    {
      "mensaje":
          "De nada, ¡nos vemos el viernes! Si necesitas algo más, no dudes en contactarnos.",
      "isSentByMe": false
    }
  ];

  // Controlador para manejar el desplazamiento de la lista de mensajes
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Después de que el marco se ha construido, desplaza la lista de mensajes hacia abajo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  // Método para desplazar la lista de mensajes hacia abajo
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      // Primero mueve sin animación al final
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      // Luego anima una pequeña cantidad para asegurarse de que esté al final
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1), // Ajusta la duración según sea necesario
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alessandro Morales', style: TextStyle(color: Colors.white)),
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
            // Expande el ListView para ocupar el espacio disponible
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: mensajes.length,
                itemBuilder: (BuildContext context, int index) {
                  return MessageWidget(
                    message: mensajes[index]['mensaje'],
                    isSentByMe: mensajes[index]['isSentByMe'],
                  );
                },
              ),
            ),
            // Campo de texto para enviar mensajes
            MyTextField(
              hint: 'Escribe un mensaje...',
              isPassword: false,
              icon: Icons.message,
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // Aquí manejas el envío del mensaje
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
