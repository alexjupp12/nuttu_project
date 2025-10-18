import 'package:flutter/material.dart';
import 'package:nuttu_project/app/theme/app_colors.dart';
// Importa el nuevo modelo de mensaje
import 'package:nuttu_project/features/chat/domain/models/message_model.dart';

class ChatDetailPage extends StatefulWidget {
  final String contactName;
  final String avatarUrl;

  const ChatDetailPage({
    super.key,
    required this.contactName,
    required this.avatarUrl,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();

  // Lista actualizada para usar el modelo Message
  final List<Message> _messages = [
    Message(
      text: 'Hola, ¿Cómo estás?', // Mensaje inicial
      sender: MessageSender.other, // Enviado por "otro" (Daniela)
    ),
  ];

  // Método de envío actualizado
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(
          Message(
            text: _messageController.text,
            sender: MessageSender.me, // Enviado por "mí"
          ),
        );
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(widget.avatarUrl),
            ),
            const SizedBox(width: 10),
            Text(widget.contactName),
          ],
        ),
      ),
      body: Column(
        children: [
          // --- Área de Mensajes ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                // Llama al widget de burbuja actualizado
                return _buildMessageBubble(message);
              },
            ),
          ),
          // --- Campo de Entrada de Texto ---
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Widget de burbuja actualizado con lógica de alineación y color
  Widget _buildMessageBubble(Message message) {
    bool isMe = message.sender == MessageSender.me;
    Color bubbleColor = isMe
        ? AppColors.color5
        : Colors.grey[300]!; // Azul (color5) si soy yo, gris si es Daniela
    Color textColor = isMe ? Colors.white : Colors.black87;
    Alignment alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7, // Ancho máximo
        ),
        child: Text(message.text, style: TextStyle(color: textColor)),
      ),
    );
  }

  // Widget para la barra de entrada de texto (sin cambios)
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(77),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: AppColors.color1),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
