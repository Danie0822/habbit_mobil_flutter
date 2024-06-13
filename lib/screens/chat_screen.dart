import 'package:flutter/material.dart';
import 'package:habbit_mobil_flutter/common/widgets/message_widget.dart';
import 'package:habbit_mobil_flutter/common/widgets/text_field_chat.dart';

class ChatScreen extends StatelessWidget {
  // Lista de mensajes
  final List<Map<String, dynamic>> mensajes = [
    {"mensaje": "Hola, ¿cómo estás?", "isSentByMe": false},
    {"mensaje": "Bien, ¿y tú?", "isSentByMe": true},
    {"mensaje": "Muy bien, gracias por preguntar. Estoy aquí para ayudarte a encontrar lo que necesitas. ¿Estás buscando algo en particular hoy?", "isSentByMe": false},
    {"mensaje": "Sí, estoy buscando una computadora portátil para juegos. ¿Tienes alguna recomendación?", "isSentByMe": true},
    {"mensaje": "¡Claro! Tenemos varias opciones excelentes en computadoras portátiles para juegos. ¿Cuál es tu presupuesto?", "isSentByMe": false},
    {"mensaje": "Mi presupuesto es de alrededor de 1500 dolares.", "isSentByMe": true},
    {"mensaje": "Perfecto, con ese presupuesto podemos ofrecerte algunas opciones con excelente rendimiento. ¿Prefieres una marca en particular?", "isSentByMe": false},
    {"mensaje": "Estoy abierto a sugerencias, pero he escuchado buenas cosas sobre ASUS y MSI.", "isSentByMe": true},
    {"mensaje": "Ambas marcas son excelentes para juegos. Te recomendaría considerar el ASUS ROG Strix o el MSI GE66 Raider. ¿Te gustaría conocer más detalles sobre alguno de ellos?", "isSentByMe": false},
    {"mensaje": "Sí, por favor, dime más sobre el ASUS ROG Strix.", "isSentByMe": true},
    {"mensaje": "El ASUS ROG Strix tiene una potente tarjeta gráfica NVIDIA RTX, un procesador rápido y una pantalla de alta frecuencia de actualización. Es perfecto para juegos exigentes.", "isSentByMe": false},
    {"mensaje": "Suena genial. ¿Viene con garantía?", "isSentByMe": true}
]
;

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
