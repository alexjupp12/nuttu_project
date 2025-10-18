class ChatItem {
  final String avatarUrl;
  final String title;
  final String subtitle;
  final int notificationCount;

  ChatItem({
    required this.avatarUrl,
    required this.title,
    required this.subtitle,
    this.notificationCount = 0,
  });
}
