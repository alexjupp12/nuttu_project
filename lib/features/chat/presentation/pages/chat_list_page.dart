import 'package:flutter/material.dart';
import 'package:nuttu_project/app/theme/app_colors.dart';
import 'package:nuttu_project/features/chat/domain/models/chat_item_model.dart';
import 'package:nuttu_project/features/chat/presentation/pages/chat_detail_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  // Lista estática de chats (luego vendrá de la API)
  final List<ChatItem> items = [
    ChatItem(
      avatarUrl: 'assets/images/Noti.png', // <-- Necesitarás esta imagen
      title: 'Nutu notificaciones',
      subtitle: 'actualizaciones y cosas nuevas',
    ),
    ChatItem(
      avatarUrl: 'assets/images/Nutu-perfil.png', // Ya tienes esta
      title: 'Nutu',
      subtitle: 'Nutu notificaciones y cosas nuevas',
    ),
    ChatItem(
      avatarUrl: 'assets/images/Daniela.png', // <-- Necesitarás esta imagen
      title: 'Daniela Diaz',
      subtitle: 'Hola, ¿Cómo estás?',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // Barra de AppBar para esta nueva pantalla
      appBar: AppBar(
        title: const Text('Chats y Notificaciones'),
        backgroundColor: AppColors.white,
        foregroundColor:
            AppColors.black, // Color del texto y la flecha de volver
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildChatItem(items[index]);
        },
      ),
    );
  }

  // Widget para construir cada tarjeta de la lista
  Widget _buildChatItem(ChatItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            // Avatar
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                item.avatarUrl,
                width: 50,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            // Insignia de notificación
            if (item.notificationCount > 0)
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    item.notificationCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          item.subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          // Lógica para abrir el chat específico
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailPage(
                contactName: item.title,
                avatarUrl: item.avatarUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}
