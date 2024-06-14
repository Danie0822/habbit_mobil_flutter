import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/message_widget.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_chat.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Lista de mensajes
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

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      // Primero mueve sin animación al final
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

      // Luego anima una pequeña cantidad para asegurarse de que esté al final
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration:
            Duration(seconds: 1), // Ajusta la duración según sea necesario
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alessandro Morales'),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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