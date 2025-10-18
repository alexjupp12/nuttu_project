// Enum para definir quién envía el mensaje
enum MessageSender {
  me, // Yo (usuario de la app)
  other, // La otra persona (Daniela)
}

class Message {
  final String text;
  final MessageSender sender;

  Message({required this.text, required this.sender});
}
